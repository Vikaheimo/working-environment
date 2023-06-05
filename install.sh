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
