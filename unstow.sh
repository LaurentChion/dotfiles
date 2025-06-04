#!/bin/sh

alias unstow='stow --delete'

declare -a packages=("kitty" "zsh" "neovim" "zellij")

for i in "${packages[@]}"
do
  echo "Unstow $i"
  unstow -t $HOME -d $HOME/dotfiles/dotfiles $i
done
