export SHELL=zsh
eval "$(sheldon source)"

# Load autocompletion
autoload -U compinit; compinit
zstyle ':completion:*' menu select
# fpath+=~/.zfunc

# Custom function to navigate
function ..() {
  cd "${1:-..}"
}

export PATH="/home/chion/.cache/.bun/bin:$PATH"

# Various alias
alias ls=eza
alias tmux=zellij
alias cat="bat -p --paging never"
alias n=nvim
alias vimdiff="nvim -d"
alias h=helix
alias md=mkdir
alias ssh="kitten ssh"

eval "$(zoxide init zsh)"

fastfetch --kitty-icat $HOME/dotfiles/ricing/goku-sunset.gif --logo-width 40

eval "$(starship init zsh)"
