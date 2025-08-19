#!/bin/sh

declare -a packages=("kitty" "zsh" "neovim" "zellij", "helix")

for i in "${packages[@]}"
do
  echo "Stow $i"
  stow -t $HOME -d $HOME/dotfiles/dotfiles $i
done
