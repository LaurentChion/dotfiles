export ZSH_CACHE_DIR=~/zsh-cache
#autoload -Uz compinit
#compinit

source ~/.zsh_plugins.sh

eval "$(starship init zsh)"

export VISUAL=code

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# GO
export PATH=$PATH:/usr/local/go/bin
export GOPATH=$HOME/go

# POETRY
export PATH=$PATH:$HOME/.poetry/bin

# CONDA
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/laurent/Software/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/laurent/Software/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/laurent/Software/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/laurent/Software/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

