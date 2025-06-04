#!/bin/sh
# Configuring kitty
stow -t $HOME -d $HOME/dotfiles/dotfiles kitty

# Configuring zsh
stow -t $HOME -d $HOME/dotfiles/dotfiles zsh

# Configuring neovim
stow -t $HOME -d $HOME/dotfiles/dotfiles neovim

# Configuring zellij
stow -t $HOME -d $HOME/dotfiles/dotfiles zellij
