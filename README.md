# Dotfiles
Install scripts and dotfiles

## Main philosophy

Here you can find my configuration files for different tools.
I may not use all of them and some file are still here from previous setup.

My main use of this repo is to clone it on a new machine and to cherry pick what I need using [Stow](https://www.gnu.org/software/stow/)

## How to use?

### Prerequisite
- Clone this repo: `git clone https://github.com/LaurentChion/dotfiles.git -o ~/.dotfiles`

### Usage

Let say I want to use my kitty config.
- Go into this cloned repository: `cd ~/.dotfiles`
- setup kitty: `stow kitty`

Some other tools are not that simple to setup and condigure to feel free to have a look on various scripts.

## Troubleshooting

### When using starship I saw conda (base) environment
Solution: Disable default display by miniconda: ´conda config --set changeps1 False´ (see https://github.com/spaceship-prompt/spaceship-prompt/issues/218#issuecomment-454722987)
