#!/bin/sh
# Checks if ZSH is installed to avoid errors
if ! command -v zsh
then
    echo "Please install ZSH before continuing"
    exit
fi

# Sets default shell to use ZSH
chsh -s $(which zsh)

# Installs oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Moves .zshrc to use
rm ~/.zshrc
cp ./.zshrc ~/

# Install better ls colors
mkdir -p ~/.shell-plugins
curl https://raw.githubusercontent.com/trapd00r/LS_COLORS/master/lscolors.sh> ~/.shell-plugins/lscolors.sh

echo "Now you have to log out and login for the changes to update. 
You might also need to install a custom powerline font for your terminal."
