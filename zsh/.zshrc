alias n=nvim
alias o="handlr open"
# alias withNvidia="__NV_PRIME_RENDER_OFFLOAD=1 __GLX_VENDOR_LIBRARY_NAME=nvidia"

export ZSH_CACHE_DIR=~/zsh-cache

autoload -Uz compinit
compinit

source ~/.zsh_plugins.sh

# set PATH so it includes user's private bin if it exists
# if [ -d "$HOME/bin" ] ; then
#     PATH="$HOME/bin:$PATH"
# fi

#set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi


eval "$(starship init zsh)"

export VISUAL=zed

zstyle ':completion:*' menu select
fpath+=~/.zfunc


# For ubuntu
# alias bat=batcat

# additional software
# export PATH=$PATH:"$HOME/softwares/fx"

export PATH=/home/lchion/.pixi/bin:$PATH

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

alias ls=eza
alias tmux=zellij
alias cat="bat -p --paging never"
eval "$(zoxide init zsh)"
export PATH="/home/lchion/.pixi/bin:$PATH"
export PATH="/home/laurent/.pixi/bin:$PATH"
