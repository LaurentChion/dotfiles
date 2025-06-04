eval "$(sheldon source)"

# Load autocompletion
autoload -U compinit; compinit
zstyle ':completion:*' menu select
# fpath+=~/.zfunc

# Custom function to navigate
function ..() {
  cd "${1:-..}"
}


# Various alias
alias ls=eza
alias tmux=zellij
alias cat="bat -p --paging never"
alias n=nvim
alias md=mkdir
eval "$(zoxide init zsh)"

fastfetch --kitty-icat $HOME/dotfiles/ricing/goku-sunset.gif --logo-width 40

eval "$(starship init zsh)"
