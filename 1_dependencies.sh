#/bin/bash

#TODO: define an install command template based on the distro
install_cmd='sudo apt install -y '
clean='sudo apt autoremove'

$install_cmd stow zsh htop curl

# install asdf
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.14.1

# install fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

# install zoxide
curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh

# install starship bar
curl -sS https://starship.rs/install.sh | sh -s -- -b ~/.local/bin

# install zed editor
curl -f https://zed.dev/install.sh | sh

$clean
