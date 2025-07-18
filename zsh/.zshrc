# Run fastfetch in the background
if [[ $TERM =~ "kitty" ]]; then
  (fastfetch)
else
  (fastfetch --config ~/.config/fastfetch/os.jsonc &)
fi

# set Zinit home
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
# Download Zinit, if it's not installed
if [ ! -d "$ZINIT_HOME" ]; then
  mkdir -p "$(dirname $ZINIT_HOME)"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi
# Load Zinit
source "${ZINIT_HOME}/zinit.zsh"

# Lazy load plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab
# Add in snippets
#zinit snippet OMZL::git.zsh
#zinit snippet OMZP::git
#zinit snippet OMZP::sudo
#zinit snippet OMZP::archlinux
#zinit snippet OMZP::aws
#zinit snippet OMZP::kubectl
#zinit snippet OMZP::kubectx
#zinit snippet OMZP::command-not-found
# Load completions
autoload -Uz compinit && compinit
zinit cdreplay -q

# History settings
#setopt INC_APPEND_HISTORY # Enable real-time history sharing
#setopt SHARE_HISTORY # Share history between all sessions.
setopt HIST_IGNORE_SPACE # Ignore commands starting with a space.
setopt HIST_REDUCE_BLANKS # Remove unnecessary blanks from commands.
setopt HIST_IGNORE_ALL_DUPS # Ignore duplicate commands in history.
setopt HIST_SAVE_NO_DUPS # Do not save duplicate commands in the history file.
setopt HIST_FIND_NO_DUPS # Do not show duplicate commands
setopt HIST_IGNORE_DUPS
HISTSIZE=1000 # Number of commands to keep in memory.
SAVEHIST=5000 # Number of commands to save in the history file.
HISTFILE=~/.zsh_history #Set history file location

# FZF
eval "$(fzf --zsh)"
# FZF settings
# add this line when u remove the transparent background
#export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
#export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
#export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:(nvim|vim):*' fzf-preview '[[ -f $realpath ]] && bat $realpath'

# Keybindings
bindkey -v
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

# Aliases
alias dotfiles="cd ~/.dotfiles"
alias ls="ls --color"
alias rmpkg="sudo pacman -Rsn"
alias cleanch="sudo pacman -Scc"
alias fixpacman="sudo rm /var/lib/pacman/db.lck"
alias update="sudo pacman -Syu"
alias cleanup="sudo pacman -Rsn \$(pacman -Qtdq)"
alias jctl="journalctl -p 3 -xb"
alias fzfp="fzf --preview 'bat --color=always --style=numbers --line-range=:500 {}'"
alias kubectl="minikube kubectl --"

# Shell integrations
eval "$(starship init zsh)"
# Add local script the path variable
export PATH="$HOME/.go/bin:$HOME/.local/bin:$PATH"
#export GOPATH="$HOME/tmux/go"
