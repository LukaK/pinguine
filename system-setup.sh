#!/bin/bash

# TODO: Define the disk
DISK=/dev/vda

# setup mkinitcpio
sed -i "/MODULES/s/()/(btrfs)/" /etc/mkinitcpio.conf
sed -i "/HOOKS/s/filesystems/encrypt filesystems/" /etc/mkinitcpio.conf
mkinitcpio -p linux

# timezone setup
ln -sf /usr/share/zoneinfo/Europe/Zagreb /etc/localtime
hwclock --systohc

# locale setup (English and Croatia)
sed -i '171s/.//' /etc/locale.gen
sed -i '273s/.//' /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" >> /etc/locale.conf
# echo "KEYMAP=de_CH-latin1" >> /etc/vconsole.conf

# hostname setup
echo "arch" >> /etc/hostname
echo "127.0.0.1 localhost" >> /etc/hosts
echo "::1       localhost" >> /etc/hosts
echo "127.0.1.1 arch.localdomain arch" >> /etc/hosts

# TODO: Set password
# setting root password
echo root:password | chpasswd

# You can remove the tlp package if you are installing on a desktop or vm
pacman -S efibootmgr networkmanager network-manager-applet dialog wpa_supplicant mtools dosfstools base-devel linux-headers avahi xdg-user-dirs xdg-utils gvfs gvfs-smb nfs-utils inetutils dnsutils bluez bluez-utils cups hplip alsa-utils pipewire pipewire-alsa pipewire-pulse pipewire-jack bash-completion openssh rsync reflector acpi acpi_call virt-manager qemu qemu-arch-extra edk2-ovmf bridge-utils dnsmasq vde2 openbsd-netcat iptables-nft ipset firewalld flatpak sof-firmware nss-mdns acpid os-prober ntfs-3g terminus-font

# graphic driver setup
# pacman -S --noconfirm xf86-video-amdgpu
pacman -S --noconfirm nvidia nvidia-utils nvidia-settings

# setup boot manager
# grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB #change the directory to /boot/efi is you mounted the EFI partition at /boot/efi
# grub-mkconfig -o /boot/grub/grub.cfg

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

# TODO: Set password and username
# setup user
useradd -m luka
echo luka:password | chpasswd
usermod -aG libvirt,wheel luka
echo "luka ALL=(ALL) ALL" >> /etc/sudoers.d/luka

# configure bootloader
bootctl --path=/boot install
echo "timeout 5" >> /boot/loader/loader.conf
echo "default arch" >> /boot/loader/loader.conf
cp ./pinguine/arch.conf /boot/loader/entries
sed -i "s/uuiddevice/$(blkid --output value ${DISK}2 | head -n 1)/" /boot/loader/entries/arch.conf
sed -i "s/uuidroot/$(blkid --output value /dev/mapper/root | head -n 1)/" /boot/loader/entries/arch.conf
cp /boot/loader/entries/arch.conf /boot/loader/entries/arch-fallback.conf
sed -i "s/initramfs-linux.img/initramfs-linux-fallback.img/" /boot/loader/entries/arch-fallback.conf


printf "\e[1;32mDone! Type exit, umount -R and reboot.\e[0m"
