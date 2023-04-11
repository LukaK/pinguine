#!/usr/bin/env zsh

# change directory to scripts directory
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
pushd $SCRIPT_DIR

mkdir -p ~/Workspace
ln -s ~/Dropbox/WorkSynced ~/Workspace/Sync
ln -s ~/Dropbox/Archive ~/Archive
ln -s ~/Dropbox/General_reference ~/General_reference
ln -s ~/Dropbox/Project_reference ~/Project_reference

# configure lightdm
sudo cp ~/Dropbox/wallpapers/wp2840961-starry-sky-wallpaper-hd.jpg /usr/share/pixmaps/
sudo cp lightdm-gtk-greeter.conf /etc/lightdm/lightdm-gtk-greeter.conf

popd

printf "\e[1;32mDone! Reboot the system\e[0m"
