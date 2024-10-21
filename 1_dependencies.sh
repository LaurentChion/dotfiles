#/bin/bash

#TODO: define an install command template based on the distro
install_cmd='sudo apt install -y '
clean='sudo apt autoremove'

# To download vscode
# firefox https://code.visualstudio.com/docs/?dv=win32user

$install_cmd stow zsh htop curl

# install starship bar
curl -sS https://starship.rs/install.sh | sh -s -- -b ~/.local/bin

# install zed editor
curl -f https://zed.dev/install.sh | sh

$clean
