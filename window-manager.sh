#!/usr/bin/env bash

# date and time setup
sudo timedatectl set-ntp true
sudo hwclock --systohc

# firewall
sudo firewall-cmd --set-default-zone=home
sudo firewall-cmd --add-service ftp --permanent
sudo firewall-cmd --remove-service ssh --permanent
sudo firewall-cmd --add-port=1025-65535/tcp --permanent
sudo firewall-cmd --add-port=1025-65535/udp --permanent
sudo firewall-cmd --add-service libvirt --zone=libvirt --permanent
sudo firewall-cmd --reload

# install paru
pushd /tmp && git clone https://aur.archlinux.org/paru && pushd paru && makepkg -si && popd && popd

# packages
paru -Sy --skipreview --noconfirm timeshift timeshift-autosnap zramd xorg lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings simplescreenrecorder obs-studio papirus-icon-theme vlc viber thunderbird keepassxc xclip google-chrome dropbox libreoffice flameshot zoom newsboat zathura zathura-djvu zathura-ps zathura-cb zathura-pdf-mupdf ttf-dejavu ttf-liberation noto-fonts nitrogen picom lxappearance pcmanfm materia-gtk-theme archlinux-wallpaper stow alacritty zsh zsh-completions cups-pdf transmission-gtk transmission-cli python-neovim xsel wl-clipboard neovim fzf htop pyenv jenv zsh-syntax-highlighting nodejs npm wget ripgrep fd slack-desktop git-remote-codecommit dex i3 xfce4-terminal ttf-font-awesome ttf-ubuntu-font-family thunar thunar-volman gvfs arandr rofi ttf-droid pacman-contrib i3lock xorg-fonts-misc siji-git ttf-unifont awesome-terminal-fonts ttf-sourcecodepro-nerd ruby python-virtualenvwrapper polybar pavucontrol feh python-pyqt5 tk yarn pyenv-virtualenv jdk-openjdk udisks2 udiskie skanlite blueman clang anki hunspell hunspell-en_us hunspell-hr appimagelauncher snapd rclone-browser

# flatpak packages
flatpak install flathub com.gitlab.ColinDuquesnoy.MellowPlayer

# snap store install
sudo snap install rambox


# enable display manager and zramd
sudo systemctl enable zramd
sudo systemctl enable lightdm
sudo systemctl enable snapd.socket

# Setup avahi service for cups
sudo sed -i '/mdns_minimal/!s/^\(hosts:.*\) \(resolve .*\)$/\1 mdns_minimal [NOTFOUND=return] \2/' /etc/nsswitch.conf

# download nord theme for lxappearance
pushd /tmp
git clone https://github.com/robertovernina/NordArc.git
sudo cp -r NordArc/NordArc-Theme /usr/share/themes
sudo cp -r NordArc/NordArc-Icons /usr/share/icons
popd

# rofi theme setup
mkdir -p ~/.local/share/rofi
pushd /tmp
git clone https://github.com/newmanls/rofi-themes-collection.git
cp -r rofi-themes-collection/themes ~/.local/share/rofi
popd

# install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
printf "\e[1;32mDone! Run local-setup.sh.\e[0m"
