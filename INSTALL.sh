#!/bin/bash

# This script is designed for automatic installation of Arch Linux on an encrypted LVM volume in an existing volume group

# Make sure you run this script as superuser (root)

# Setting variables
VG_NAME="mainvg"  # Specify the name of the existing volume group
LV_ROOT="mining_randomx"  # Name of the logical volume for root
EFI_DEV="/dev/nvme0n1p1"
BTRFS_BOOT_DEV="/dev/nvme0n1p9"
BTRFS_BOOT_SUBVOL="@mining_randomx_boot"

ROOT_VOLUME_SIZE="10G"
EXTRA_VOLUME_UUID="5fabedda-b832-4509-af6a-014f56e5e502" # if there's no extra partition with Monero blockchain, the size of 10G should be changed to an acceptable value

SOFT_PACK2="networkmanager btrfs-progs nano vim mc man-db less htop tmux monero p2pool xmrig ntfs-3g dosfstools lvm2 cryptsetup"


# Update time
timedatectl set-ntp true

echo "test test"
setfont cyr-sun16
echo "test test"

# Display information about block devices
lsblk
echo "specified: EFI: $EFI_DEV, Btrfs partition to add boot to: $BTRFS_BOOT_DEV, LVM volume group: $VG_NAME (all of this should already be created before running the script)"
echo "what will be created: $BTRFS_BOOT_SUBVOL - subvolume for boot in btrfs, $LV_ROOT - volume in LVM, these names must not be taken and will be created by the script"
echo "if the partitions are not properly prepared, press ctrl+C to interrupt the script and prepare the partitions"
read EMPTY


# Download packages needed for installation
pacman -Suy
packages=("arch-install-scripts" "lvm2" "cryptsetup")

for pkg in "${packages[@]}"; do
    if ! pacman -Qi "$pkg" &>/dev/null; then
        sudo pacman -S "$pkg" --noconfirm
    fi
done


# Create new logical volumes
echo "ATTENTION! YES must be written in CAPITAL letters"
lvcreate -L $ROOT_VOLUME_SIZE $VG_NAME -n $LV_ROOT

# Encrypt logical volumes
cryptsetup luksFormat /dev/$VG_NAME/$LV_ROOT

# Open encrypted volumes
cryptsetup open /dev/$VG_NAME/$LV_ROOT cryptroot

# Format logical volumes
mkfs.ext4 /dev/mapper/cryptroot

# Mount filesystem to /mnt/system_installing
mkdir -p /mnt/system_installing
mount /dev/mapper/cryptroot /mnt/system_installing

# Create directories for future mounts
mkdir -p /mnt/system_installing/boot


# Mount Btrfs partition and create subvolume for /boot
# (can be skipped if subvolume is already created)
mkdir -p /mnt/btrfs
mount $BTRFS_BOOT_DEV /mnt/btrfs
btrfs subvolume create /mnt/btrfs/$BTRFS_BOOT_SUBVOL
umount /mnt/btrfs

# Mount subvolume for /boot
mount -o subvol=$BTRFS_BOOT_SUBVOL $BTRFS_BOOT_DEV /mnt/system_installing/boot


# Mount EFI partition
mkdir -p /mnt/system_installing/boot/efi
mount $EFI_DEV /mnt/system_installing/boot/efi
# when installing from an already installed Arch, not from an ISO, there won't be problems, as two mount points can exist simultaneously

# Install base system
pacstrap /mnt/system_installing base linux linux-firmware btrfs-progs lvm2 cryptsetup

# Generate fstab
genfstab -U /mnt/system_installing >> /mnt/system_installing/etc/fstab

mkdir /mnt/system_installing/mnt/extra1
echo "UUID=$EXTRA_VOLUME_UUID	/mnt/extra1    	ext4      	rw,relatime	0 2" >> /mnt/system_installing/etc/fstab

# Configure encrypted partition
echo "cryptroot UUID=$(blkid -s UUID -o value /dev/$VG_NAME/$LV_ROOT) none luks" > /mnt/system_installing/etc/crypttab

echo "GRUB_CMDLINE_LINUX=\"cryptdevice=/dev/$VG_NAME/$LV_ROOT:cryptroot root=/dev/mapper/cryptroot\"" >> /mnt/system_installing/etc/default/grub



# Get directory name
SCRIPT_DIR=$(dirname "${BASH_SOURCE[0]}")
# Copy additional script to run inside the system (should be in the same directory as this one)
cp $SCRIPT_DIR/run_inside_chroot.sh /mnt/system_installing
# Copy README file
cp $SCRIPT_DIR/homefiles.tar.gz /mnt/system_installing


#-------------------------------
# Chroot into the new system
arch-chroot /mnt/system_installing /bin/bash -c "./run_inside_chroot.sh \"$SOFT_PACK2\""
#-------------------------------


# Remove the copy of the second script that ran in chroot
rm /mnt/system_installing/run_inside_chroot.sh 


# Unmount
umount -R /mnt/system_installing


cryptsetup close cryptroot

echo "ALL DONE"

echo "If the bootloader is installed by another Linux, don't forget to run update-grub (or grub-mkconfig -o /boot/grub/grub.cfg) in it"

# Reboot
echo "Installation complete. Reboot your computer."
