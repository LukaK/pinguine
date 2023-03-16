#!/bin/bash

# TODO: Define the disk
DISK="/dev/vda"

# partition the disk
echo "Partitioning the disk $DISK..."
sgdisk -n 1:0:+300M -t 1:ef00 -n 2:301M $DISK

# format the disks
echo "Formatting the disk..."
mkfs.fat -F32 "${DISK}1"
cryptsetup --cipher aes-xts-plain64 --hash sha512 --use-random --verify-passphrase luksFormat "${DISK}2"
cryptsetup luksOpen "${DISK}2" root
mkfs.btrfs /dev/mapper/root

# create subvolumes
echo "Creating btrfs subvolumes..."
mount /dev/mapper/root /mnt
pushd /mnt
btrfs subvolume create @
btrfs subvolume create @home
popd
umount /mnt

# mount subvolumes
echo "Mounting partitions to /mnt..."
mount -o noatime,space_cache=v2,compress=zstd,ssd,discard=async,subvol=@ /dev/mapper/root /mnt
mkdir /mnt/{boot,home}
mount -o noatime,space_cache=v2,compress=zstd,ssd,discard=async,subvol=@home /dev/mapper/root /mnt/home
mount "${DISK}1" /mnt/boot

# NOTE: Change intel-ucode to amd-ucode for amd processor
# base system
echo "Pacstraping the system..."
pacstrap /mnt base linux linux-firmware git vim intel-ucode

echo "Use arch-chroot /mnt and run base-ufi script"
