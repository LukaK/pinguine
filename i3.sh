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
# git clone https://aur.archlinux.org/paru && pushd paru && makepkg -si && popd

# packages
paru -S --skipreview timeshift timeshift-autosnap zramd xorg lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings simplescreenrecorder obs-studio papirus-icon-theme vlc viber thunderbird keepassxc xclip google-chrome dropbox libreoffice flameshot zoom newsboat zathura zathura-djvu zathura-ps zathura-cb zathura-pdf-mupdf ttf-dejavu ttf-liberation noto-fonts nitrogen picom lxappearance pcmanfm materia-gtk-theme archlinux-wallpaper stow alacritty zsh zsh-completions cups-pdf transmission-gtk transmission-cli python-neovim xsel wl-clipboard neovim fzf htop pyenv jenv zsh-syntax-highlighting nodejs npm wget ripgrep fd slack-desktop git-remote-codecommit dex i3 xfce4-terminal ttf-font-awesome ttf-ubuntu-font-family thunar thunar-volman gvfs arandr rofi ttf-droid pacman-contrib i3lock xorg-fonts-misc siji-git ttf-unifont awesome-terminal-fonts ttf-sourcecodepro-nerd ruby python-virtualenvwrapper


# enable display manager
sudo systemctl enable zramd
sudo systemctl enable lightdm

# oh-my-zsh with powerlevel 10k
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# setup virtualenvwrapper with pyenv
git clone https://github.com/pyenv/pyenv-virtualenvwrapper.git $(pyenv root)/plugins/pyenv-virtualenvwrapper

# avahi setup for cups and so on

# cusomizing themes with lxappearance, rofi-theme-selector

# customize greeter

# Download dotfiles
# TODO: Setit up
git clone https://github.com/LukaK/dotfiles

# Download neovim configuration
git clone https://github.com/LukaK/spacecow ~/.config/nvim

# TODO: Download dropbox files and link them
# TODO: Zsh syntax highlighting not working

/bin/echo -e "\e[1;32mREBOOTING IN 5..4..3..2..1..\e[0m"
sleep 5
reboot
