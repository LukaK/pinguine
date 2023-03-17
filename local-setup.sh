#!/usr/bin/env zsh

# zsh configuration
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# setup virtualenvwrapper with pyenv
git clone https://github.com/pyenv/pyenv-virtualenvwrapper.git $(pyenv root)/plugins/pyenv-virtualenvwrapper

# setup dotfiles
git clone https://github.com/LukaK/dotfiles
pushd dotfiles && stow --adopt -t ~ */ && git reset --hard HEAD && popd

source ~/.zshrc

# Download neovim configuration and setup python provider venv
pyenv install 3.7.9
pyenv virtualenv 3.7.9 py3nvim
pyenv activate py3nvim
python3 -m pip install pynvim
pyenv deactivate py3nvim
git clone https://github.com/LukaK/spacecow ~/.config/nvim


# TODO: Setup this
# torrents setup
mkdir -p Torrents/{Complete,Incomplete}


# NOTE: Install python plugins for lps wiht lsp install
# NOTE: customize lxappearance (lxappearance)
# NOTE: customize greeter (lightdm-gtk-greeter-settings)
# NOTE: configure credentials for github and configure repositoryes for push privilages
# NOTE: Podesi timeshift

/bin/echo -e "\e[1;32mREBOOTING IN 5..4..3..2..1..\e[0m"
sleep 5
reboot
