#!/bin/sh
# Please have ZSH installed beforehand!

# Sets default shell to use ZSH
chsh -s $(which zsh)

# Installs oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Moves .zshrc to use
mv ~/.zshrc ~/before/
cp ./.zshrc ~/


