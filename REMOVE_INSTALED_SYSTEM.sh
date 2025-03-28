#!/bin/bash

# Setting variables
LVM_VOLUME="/dev/mainvg/mining_randomx"
BTRFS_DEVICE="/dev/nvme0n1p9"
BTRFS_SUBVOLUME="@mining_randomx_boot"
MOUNT_POINT="/mnt/btrfs_mount"

# Removing LVM volume
echo "Removing LVM volume: $LVM_VOLUME"
if lvdisplay $LVM_VOLUME &>/dev/null; then
    sudo lvremove -y $LVM_VOLUME
    if [ $? -eq 0 ]; then
        echo "LVM volume $LVM_VOLUME successfully removed."
    else
        echo "Error when removing LVM volume $LVM_VOLUME."
        exit 1
    fi
else
    echo "LVM volume $LVM_VOLUME not found."
fi

# Mounting Btrfs partition
echo "Mounting Btrfs partition: $BTRFS_DEVICE"
sudo mkdir -p $MOUNT_POINT
sudo mount $BTRFS_DEVICE $MOUNT_POINT
if [ $? -ne 0 ]; then
    echo "Error when mounting Btrfs partition $BTRFS_DEVICE."
    exit 1
fi

# Removing Btrfs subvolume
echo "Removing subvolume: $BTRFS_SUBVOLUME"
if sudo btrfs subvolume show $MOUNT_POINT/$BTRFS_SUBVOLUME &>/dev/null; then
    sudo btrfs subvolume delete $MOUNT_POINT/$BTRFS_SUBVOLUME
    if [ $? -eq 0 ]; then
        echo "Subvolume $BTRFS_SUBVOLUME successfully removed."
    else
        echo "Error when removing subvolume $BTRFS_SUBVOLUME."
        sudo umount $MOUNT_POINT
        exit 1
    fi
else
    echo "Subvolume $BTRFS_SUBVOLUME not found."
fi

# Unmounting Btrfs partition
echo "Unmounting Btrfs partition: $BTRFS_DEVICE"
sudo umount $MOUNT_POINT
if [ $? -eq 0 ]; then
    echo "Btrfs partition $BTRFS_DEVICE successfully unmounted."
else
    echo "Error when unmounting Btrfs partition $BTRFS_DEVICE."
    exit 1
fi

echo "Operations completed."
