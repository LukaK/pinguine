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
paru -S --skipreview timeshift timeshift-autosnap zramd xorg lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings simplescreenrecorder obs-studio papirus-icon-theme vlc viber thunderbird keepassxc xclip google-chrome dropbox libreoffice flameshot zoom newsboat zathura zathura-djvu zathura-ps zathura-cb zathura-pdf-mupdf ttf-dejavu ttf-liberation noto-fonts nitrogen picom lxappearance pcmanfm materia-gtk-theme archlinux-wallpaper stow alacritty zsh zsh-completions cups-pdf transmission-gtk transmission-cli python-neovim xsel wl-clipboard neovim fzf htop pyenv jenv zsh-syntax-highlighting nodejs npm wget ripgrep fd slack-desktop git-remote-codecommit dex i3 xfce4-terminal ttf-font-awesome ttf-ubuntu-font-family thunar thunar-volman gvfs arandr rofi ttf-droid pacman-contrib i3lock xorg-fonts-misc siji-git ttf-unifont awesome-terminal-fonts ttf-sourcecodepro-nerd ruby python-virtualenvwrapper polybar pavucontrol feh python-pyqt5


# enable display manager
sudo systemctl enable zramd
sudo systemctl enable lightdm

# setup virtualenvwrapper with pyenv
git clone https://github.com/pyenv/pyenv-virtualenvwrapper.git $(pyenv root)/plugins/pyenv-virtualenvwrapper

# download nord theme for lxappearance
git clone https://github.com/robertovernina/NordArc.git
sudo cp -r NordArc/NordArc-Theme /usr/share/themes
sudo cp -r NordArc/NordArc-Icons /usr/share/icons
rm -rf NordArc

# Download dotfiles
git clone https://github.com/LukaK/dotfiles
pushd dotfiles && stow --adopt -t ~ */ && git reset --hard HEAD && popd

# Download neovim configuration
git clone https://github.com/LukaK/spacecow ~/.config/nvim

# rofi theme setup
mkdir ~/local/share/rofi
pushd /tmp
git clone https://github.com/newmanls/rofi-themes-collection.git
cp -r rofi-themes-collection/themes ~/.local/share/rofi
popd

# TODO: Zsh syntax highlighting not working

# TODO: This breaks things if you set zsh as the default shell
# breaks installation changing of the shell
# oh-my-zsh with powerlevel 10k
# sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# NOTE: customize greeter (lightdm-gtk-greeter-settings)
# NOTE: customize lxappearance (lxappearance)

# /bin/echo -e "\e[1;32mREBOOTING IN 5..4..3..2..1..\e[0m"
# sleep 5
# reboot
