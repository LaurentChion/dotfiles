alias n=nvim
alias o="handlr open"

# autoload -Uz compinit
# compinit

eval "$(sheldon source)"

eval "$(starship init zsh)"

zstyle ':completion:*' menu select
fpath+=~/.zfunc

# [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

alias ls=eza
alias tmux=zellij
alias cat="bat -p --paging never"
eval "$(zoxide init zsh)"

fastfetch --kitty-icat $HOME/dotfiles/ricing/goku-sunset.gif --logo-width 40
