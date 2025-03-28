## Description

This is a highly specialized Arch Linux installation for Monero mining with no unnecessary components. It assumes that the Monero blockchain is stored on a separate partition, which will be added to `fstab` by the script.  
If no such partition exists, the default 10 GB system partition size should be increased to a suitable value.

## Features

### Installation Script

This version of the script is designed for:

1. Installing the system onto a newly created password-encrypted partition inside an existing unencrypted LVM volume.
2. Creating a new boot volume on an already existing Btrfs partition (optionally, this partition can be on a removable device).
3. Installing on UEFI-based PCs. (The EFI partition can also reside on a removable device if desired.)  
   For older PCs (e.g. pre-2012 BIOS systems), the script requires minor modifications.
4. The most convenient way to install from the [official Arch ISO](https://archlinux.org/download/) is to use a USB stick prepared with [Ventoy](https://github.com/ventoy/Ventoy).
5. When using Ventoy, place the Arch ISO onto the boot images partition, and place the installation scripts on an additional partition that can be added to the USB drive during Ventoy setup.
6. The script can also be run from an already installed Arch system to install a second minimal Arch system (without GUI) for Monero mining with no extra packages.

### System

* After installation, the system will use `tmux` to split the bare TTY console into 4 panes:
  * Monero wallet
  * `p2pool` node
  * Miner
  * `htop` for system load monitoring

## Usage

A few mandatory preparations before running the installer:

* Open the script in a text editor and edit the variable values at the beginning to match your system.  
  If desired, you can review the script to understand what it does.
* The disk layout must include:
  * An existing LVM volume group, where a new logical volume with the encrypted LUKS container and system will be added
  * A Btrfs partition, which will be used to create a subvolume for the /boot mountpoint

### Installation

```bash
./INSTALL.sh
```

Run as root.

### Starting Monero Mining

After installation:

```bash
~/temuxed_mnr_mining.sh
```

See [README-mining.md](README-mining.md) for reference info on using the `tmux` utility.

### Internet

* Ethernet should connect automatically.
* For Wi-Fi, refer to the following README files:
  * [README-wifi-iwctl(iwd).md](README-wifi-iwctl(iwd).md) – connecting to Wi-Fi from the installation ISO
  * [README-wifi.md](README-wifi.md) – connecting to Wi-Fi via NetworkManager in the installed system
