# Dotfiles
Install scripts and dotfiles

## Main philosophy

Here you can find my configuration files for different tools.
I may not use them all at once.

My main use of this repo is to clone it on a new machine and to cherry pick what I need using [Stow](https://www.gnu.org/software/stow/)

## Usage example:

### Prerequisite
- Clone this repo

Let say I want to use my kitty config.
- Go into this cloned repository
- execute ´stow kitty´


## Troubleshooting

### When using starship I saw conda (base) environment
Solution: Disable default display by miniconda: ´conda config --set changeps1 False´ (see https://github.com/spaceship-prompt/spaceship-prompt/issues/218#issuecomment-454722987)
