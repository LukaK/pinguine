#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
pushd $SCRIPT_DIR

source ./environment.sh

PARTITION2="$(fdisk -l $DISK | tail -1 | awk '{print $1}')"

# setup mkinitcpio
sed -i "/MODULES/s/()/(btrfs)/" /etc/mkinitcpio.conf
sed -i "/HOOKS/s/filesystems/encrypt filesystems/" /etc/mkinitcpio.conf
mkinitcpio -p linux

# timezone setup
ln -sf /usr/share/zoneinfo/Europe/Zagreb /etc/localtime
hwclock --systohc

# locale setup (English and Croatia)
sed -i '171s/#\(en_US.UTF-8\)/\1/' /etc/locale.gen
sed -i '273s/#\(hr_HR.UTF-8\)/\1/' /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" >> /etc/locale.conf

# hostname setup
echo "arch" >> /etc/hostname
echo "127.0.0.1 localhost" >> /etc/hosts
echo "::1       localhost" >> /etc/hosts
echo "127.0.1.1 arch.localdomain arch" >> /etc/hosts

# setting root password
echo root:$ROOT_PASSWORD | chpasswd

# You can remove the tlp package if you are installing on a desktop or vm
pacman -Sy efibootmgr networkmanager network-manager-applet dialog wpa_supplicant mtools dosfstools base-devel linux-headers avahi xdg-user-dirs xdg-utils gvfs gvfs-smb nfs-utils inetutils dnsutils bluez bluez-utils cups hplip alsa-utils pipewire pipewire-alsa pipewire-pulse pipewire-jack bash-completion openssh rsync rclone reflector acpi acpi_call virt-manager qemu qemu-arch-extra edk2-ovmf bridge-utils dnsmasq vde2 openbsd-netcat iptables-nft ipset firewalld flatpak sof-firmware nss-mdns acpid os-prober ntfs-3g terminus-font ctags

# graphic driver setup
if (( ${#GPU_PACKAGES[@]} != 0 ));
then
    pacman -Sy --noconfirm ${GPU_PACKAGES[@]}
fi

# enable services
systemctl enable NetworkManager
systemctl enable bluetooth
systemctl enable cups.service
systemctl enable sshd
systemctl enable avahi-daemon
# systemctl enable tlp # You can comment this command out if you didn't install tlp, see above
systemctl enable reflector.timer
systemctl enable fstrim.timer
systemctl enable libvirtd
systemctl enable firewalld
systemctl enable acpid

# setup user
useradd -m luka
echo $USER_NAME:$USER_PASSWORD | chpasswd
usermod -aG libvirt,wheel $USER_NAME
echo "$USER_NAME ALL=(ALL) ALL" >> /etc/sudoers.d/$USER_NAME

# configure bootloader
bootctl --path=/boot install
echo "timeout 5" >> /boot/loader/loader.conf
echo "default arch" >> /boot/loader/loader.conf
cp arch.conf /boot/loader/entries
sed -i "s/uuiddevice/$(blkid --output value ${PARTITION2} | head -n 1)/" /boot/loader/entries/arch.conf
sed -i "s/uuidroot/$(blkid --output value /dev/mapper/root | head -n 1)/" /boot/loader/entries/arch.conf
cp /boot/loader/entries/arch.conf /boot/loader/entries/arch-fallback.conf
sed -i "s/initramfs-linux.img/initramfs-linux-fallback.img/" /boot/loader/entries/arch-fallback.conf


popd
printf "\e[1;32mDone! Type exit, umount -R /mnt, reboot and run wingow-manager.sh.\e[0m"
