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
git clone https://aur.archlinux.org/paru && pushd paru && makepkg -si && popd

# packages
paru -S --skipreview timeshift timeshift-autosnap zramd xorg lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings simplescreenrecorder obs-studio papirus-icon-theme vlc viber thunderbird keepassxc xclip google-chrome dropbox libreoffice flameshot zoom newsboat zathura zathura-djvu zathura-ps zathura-cb zathura-pdf-mupdf ttf-dejavu ttf-liberation noto-fonts nitrogen picom lxappearance pcmanfm materia-gtk-theme archlinux-wallpaper stow alacritty zsh zsh-completions cups-pdf transmission-gtk transmission-cli python-neovim xsel wl-clipboard neovim fzf htop pyenv jenv zsh-syntax-highlighting nodejs npm wget ripgrep fd slack-desktop git-remote-codecommit dex i3 xfce4-terminal ttf-font-awesome ttf-ubuntu-font-family thunar thunar-volman gvfs arandr rofi ttf-droid pacman-contrib i3lock xorg-fonts-misc siji-git ttf-unifont awesome-terminal-fonts ttf-sourcecodepro-nerd ruby python-virtualenvwrapper polybar pavucontrol feh python-pyqt5 tk yarn pyenv-virtualenv jdk-openjdk udisks2 udiskie skanlite blueman


# enable display manager and zramd
sudo systemctl enable zramd
sudo systemctl enable lightdm

# Setup avahi service for cups
sudo sed -i '/mdns_minimal/!s/^\(hosts:.*\) \(resolve .*\)$/\1 mdns_minimal [NOTFOUND=return] \2/' /etc/nsswitch.conf

# setup virtualenvwrapper with pyenv
git clone https://github.com/pyenv/pyenv-virtualenvwrapper.git $(pyenv root)/plugins/pyenv-virtualenvwrapper

# download nord theme for lxappearance
git clone https://github.com/robertovernina/NordArc.git
sudo cp -r NordArc/NordArc-Theme /usr/share/themes
sudo cp -r NordArc/NordArc-Icons /usr/share/icons
rm -rf NordArc

# TODO: Oh my zsh will overwrite this setup should go after the shell
# Download dotfiles
git clone https://github.com/LukaK/dotfiles
pushd dotfiles && stow --adopt -t ~ */ && git reset --hard HEAD && popd

# TODO: pynvim nije dobro instaliran (reloading or sourcing shell)
# Download neovim configuration and setup python provider venv
pyenv install 3.7.9
pyenv virtualenv 3.7.9 py3nvim
pyenv activate py3nvim
python3 -m pip install pynvim
pyenv deactivate py3nvim
git clone https://github.com/LukaK/spacecow ~/.config/nvim

# rofi theme setup
mkdir ~/.local/share/rofi
pushd /tmp
git clone https://github.com/newmanls/rofi-themes-collection.git
cp -r rofi-themes-collection/themes ~/.local/share/rofi
popd

# TODO: Setup this
# torrents setup
mkdir -p Torrents/{Complete,Incomplete}

# zsh configuration
# TODO: This breaks things if you set zsh as the default shell
# sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# NOTE: Install python plugins for lps wiht lsp install
# NOTE: customize lxappearance (lxappearance)
# NOTE: customize greeter (lightdm-gtk-greeter-settings)
# NOTE: configure credentials for github and configure repositoryes for push privilages

/bin/echo -e "\e[1;32mREBOOTING IN 5..4..3..2..1..\e[0m"
sleep 5
reboot
