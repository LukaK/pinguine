#!/usr/bin/env zsh

# zsh configuration
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# setup virtualenvwrapper with pyenv
git clone https://github.com/pyenv/pyenv-virtualenvwrapper.git $(pyenv root)/plugins/pyenv-virtualenvwrapper

# setup dotfiles
git clone https://github.com/LukaK/dotfiles ~/dotfiles
pushd ~/dotfiles && stow --adopt -t ~ */ && git reset --hard HEAD && popd

# enable user space services
systemctl --user enable --now picom
systemctl --user enable --now caa-sync.timer

# user space service configuraiton
mkdir -p $HOME/.ssh/rclone
cp org-sync-environment $HOME/.ssh/rclone/environment && chmod 400 $HOME/.ssh/rclone/environment

source ~/.zshrc

# Download neovim configuration and setup python provider venv
pyenv install 3.7.9
pyenv virtualenv 3.7.9 py3nvim
pyenv activate py3nvim
python3 -m pip install pynvim
pyenv deactivate py3nvim
git clone https://github.com/LukaK/spacecow ~/.config/nvim


# torrents setup
mkdir -p ~/Torrents/{Complete,Incomplete}

printf "\e[1;32mDone! Setup dropbox login and run dropbox-setup.sh\e[0m"
