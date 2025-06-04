# fix for ctrl + arrow
bindkey '^[[1;5D' backward-word
bindkey '^[[1;5C' forward-word

eval "$(sheldon source)"

# Load autocompletion
autoload -U compinit; compinit
zstyle ':completion:*' menu select
# fpath+=~/.zfunc

# Various alias
alias ls=eza
alias tmux=zellij
alias cat="bat -p --paging never"
alias n=nvim

eval "$(zoxide init zsh)"

fastfetch --kitty-icat $HOME/dotfiles/ricing/goku-sunset.gif --logo-width 40

eval "$(starship init zsh)"
