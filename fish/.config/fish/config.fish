if status is-login
    # Commands here run ONLY in login shells
    #set -gx PATH $HOME/.local/bin $PATH

    # Setup fzf color
    # --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \

    set -gx FZF_DEFAULT_OPTS " \
	    --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
	    --color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 \
	    --color=selected-bg:#45475a \
	    --multi"

    # Editor settings
    set -gx EDITOR vim
    set -gx SUDO_EDITOR $EDITOR

    # set -gx GOPATH $HOME/.go
end

if status is-interactive
  # Commands to run in interactive sessions can go here
  # =============================================================================
  # 1. Fastfetch Startup
  # =============================================================================
  # Run fastfetch in the background
  if string match -q "*kitty*" $TERM
    fastfetch
  else
    # Fish backgrounding syntax (& at the end of the command)
    fastfetch --config ~/.config/fastfetch/os.jsonc &
  end

  # =============================================================================
  # 2. Plugins & Completions (Fisher Equivalent)
  # =============================================================================
  # Note: Fish handles syntax highlighting and autosuggestions natively!
  # To replicate fzf-tab and zsh-completions, install 'Fisher' and run:
  # fisher install PatrickF1/fzf.fish
  # fisher install pure-fish/pure (or use starship below)
  # fisher install catppuccin/fish

  # =============================================================================
  # 3. History Settings
  # =============================================================================
  # Fish handles history duplicate reduction and real-time sharing automatically.
  # To ignore commands starting with a space:
  #set -g fish_history_ignore_space

  # Note: Fish saves history in a different format natively,
  # so HISTSIZE and HISTFILE tweaks aren't strictly mapped like Zsh.

  # =============================================================================
  # 4. Environment Variables & FZF
  # =============================================================================
  # Bat theme
  #set -gx BAT_THEME "Catppuccin Mocha"

  # FZF initialization for Fish
  fzf --fish | source

  # Uncomment if needed:
  # set -gx FZF_DEFAULT_COMMAND "fd --hidden --strip-cwd-prefix --exclude .git"
  # set -gx FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"
  # set -gx FZF_ALT_C_COMMAND "fd --type=d --hidden --strip-cwd-prefix --exclude .git"

  # =============================================================================
  # 5. Keybindings
  # =============================================================================
  # Enable Vi mode
  fish_vi_key_bindings

  # Custom keybindings (Fish uses 'bind' instead of 'bindkey')
  # Note: Ctrl+P and Ctrl+N for history search
  #bind -M insert \cp history-search-backward
  #bind -M insert \cn history-search-forward
  #bind \cp history-search-backward
  #bind \cn history-search-forward

  # =============================================================================
  # 6. Aliases
  # =============================================================================
  alias dotfiles="cd ~/.dotfiles"
  alias ls="ls --color"
  alias rmpkg="sudo pacman -Rsn"
  alias cleanch="sudo pacman -Scc"
  alias clean="sudo pacman -Sc"
  alias cleanAur="yay -Yc"
  alias fixpacman="sudo rm /var/lib/pacman/db.lck"
  alias update="sudo pacman -Syu"
  alias cleanup="sudo pacman -Rsn (pacman -Qtdq)" # Changed $() to ()
  alias jctl="journalctl -p 3 -xb"
  alias fzfp="fzf --preview 'bat --color=always --style=numbers --line-range=:500 {}'"
  alias kubectl="minikube kubectl --"

  # =============================================================================
  # 7. Functions
  # =============================================================================
  function weee
    curl "http://wttr.in/$argv[1]"
  end

  function dict
    curl "dict://dict.org/d:$argv[1]"
  end

  # =============================================================================
  # 8. Shell Integrations & PATH
  # =============================================================================
  # Starship Prompt
  starship init fish | source

  # Path modifications (Fish uses a clean array structure for fish_user_paths)
  #fish_add_path $HOME/.go/bin
  #fish_add_path $HOME/.local/bin
end
