#!/bin/sh
# Configuring kitty
stow -t $HOME -d $HOME/dotfiles/dotfiles --delete kitty

# Configuring zsh
stow -t $HOME -d $HOME/dotfiles/dotfiles --delete zsh

# Configuring neovim
stow -t $HOME -d $HOME/dotfiles/dotfiles --delete neovim

# Configuring zellij
stow -t $HOME -d $HOME/dotfiles/dotfiles --delete zellij
