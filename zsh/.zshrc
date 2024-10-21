alias nvim=$HOME/softwares/neovim/install/bin/nvim
alias n=nvim
alias o=xdg-open
alias withNvidia="__NV_PRIME_RENDER_OFFLOAD=1 __GLX_VENDOR_LIBRARY_NAME=nvidia"

export ZSH_CACHE_DIR=~/zsh-cache

source ~/.zsh_plugins.sh

# set PATH so it includes user's private bin if it exists
# if [ -d "$HOME/bin" ] ; then
#     PATH="$HOME/bin:$PATH"
# fi

# set PATH so it includes user's private bin if it exists
# if [ -d "$HOME/.local/bin" ] ; then
#     PATH="$HOME/.local/bin:$PATH"
# fi

# autoload -Uz compinit
# compinit

eval "$(starship init zsh)"

export VISUAL=zed

# NVM
# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# GO
# export PATH=$PATH:/usr/local/go/bin
# export GOPATH=$HOME/go

# POETRY
# export PATH=$PATH:$HOME/.poetry/bin

# CONDA
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('$HOME/softwares/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "$HOME/softwares/miniconda3/etc/profile.d/conda.sh" ]; then
        . "$HOME/softwares/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="$HOME/softwares/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup

if [ -f "$HOME/softwares/miniconda3/etc/profile.d/mamba.sh" ]; then
    . "$HOME/softwares/miniconda3/etc/profile.d/mamba.sh"
fi
# <<< conda initialize <<<


zstyle ':completion:*' menu select
fpath+=~/.zfunc

# Haskell
# [ -f "$HOME/.ghcup/env" ] && source "$HOME/.ghcup/env" # ghcup-env

# For ubuntu
alias bat=batcat

# additional software
export PATH=$PATH:"$HOME/softwares/fx"
# Spyware from securtity
# export REQUESTS_CA_BUNDLE="$HOME/softwares/Netskope.pem"
# export NODE_EXTRA_CA_CERTS="$HOME/softwares/Netskope.pem"

export PATH=/home/lchion/.pixi/bin:$PATH
