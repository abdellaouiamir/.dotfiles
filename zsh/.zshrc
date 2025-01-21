eval "$(starship init zsh)"


# Run fastfetch in the background
#(fastfetch &)
if [[ $TERM =~ "kitty" ]]; then
  fastfetch
else
  fastfetch --config ~/.config/fastfetch/os.jsonc
fi
# History settings
export HISTCONTROL=ignoreboth
export HISTIGNORE="&:[bf]g:clear:history:exit:q:pwd:* --help"
HISTSIZE=10000
SAVEHIST=50000

# Editor settings
export EDITOR="nvim"
export SUDO_EDITOR="$EDITOR"

# Completion settings
COMPLETION_WAITING_DOTS="true"


# Lazy load plugins
zsh_plugins=(
  /usr/share/zsh/plugins/fzf-tab/fzf-tab.plugin.zsh
  /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
  /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
  /usr/share/zsh/plugins/zsh-completions/zsh-completions.plugin.zsh
  /usr/share/doc/pkgfile/command-not-found.zsh
)
autoload -U compinit; compinit
for plugin in "${zsh_plugins[@]}"; do
  if [[ -f "$plugin" ]]; then
    source "$plugin"
  fi
done

# FZF settings
export FZF_BASE=/usr/share/fzf

# Aliases
alias rmpkg="sudo pacman -Rsn"
alias cleanch="sudo pacman -Scc"
alias fixpacman="sudo rm /var/lib/pacman/db.lck"
alias update="sudo pacman -Syu"
alias cleanup="sudo pacman -Rsn \$(pacman -Qtdq)"
alias jctl="journalctl -p 3 -xb"

