# Dotfiles

Install scripts and dotfiles

## Main philosophy

Here is my configuration files for different tools that I use.

The idea is to create a container, install needed tool for developement and to setup various configuration without the need of admin rights.

## How to use?

### Requirements
- [Podman](https://podman.io/) (recommended) or [Docker](https://www.docker.com/) (not tested)
- [Distrobox](https://distrobox.it/)

### Usage

- Clone this repo in your HOME directory: `git clone https://github.com/LaurentChion/dotfiles.git -o ~/.dotfiles`
- Go into it: `cd dotfiles`
- Create the container: `distrobox assemble create`
- Load configurations: `./scripts/stow.sh`
