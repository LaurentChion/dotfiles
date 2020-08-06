export ZSH_CACHE_DIR=~/zsh-cache
autoload -Uz compinit
compinit
source ~/.zsh_plugins.sh
eval "$(starship init zsh)"