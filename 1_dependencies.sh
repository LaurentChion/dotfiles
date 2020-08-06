#/bin/bash

#TODO: define an install command template based on the distro

if command -v apt
then
  echo "APT deteted"
  install_cmd='sudo apt install -y '
  clean='sudo apt autoremove'
elif command -v dnf
then
  echo "DNF detected"
  # FIXME: define install and clean command
  install_cmd='sudo dnf install -y '
  clean=''
elif command -v pacman
then
  echo "PACMAN detected"
  # FIXME: define install and clean command
  install_cmd='sudo pacman -Syu '
  clean=''
else
  echo "Install command not found "
fi

$install_cmd stow zsh htop curl
$clean

# Install starship
curl -fsSL https://starship.rs/install.sh | bash

# Getting antibody (zsh package manager)
echo "Installing zsh packages"
curl -sfL git.io/antibody | sh -s - -b .

