#[[ -f ~/.zshrc ]] && . ~/.zshrc
# Setup fzf color
#--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
export FZF_DEFAULT_OPTS=" \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 \
--color=selected-bg:#45475a \
--multi"
# Editor settings
export EDITOR="nvim"
export SUDO_EDITOR="$EDITOR"

# Add local script the path variable
export PATH="$HOME/.local/bin:$PATH"

