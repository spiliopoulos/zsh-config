# ============================================
# MODERN TOOLS INITIALIZATION
# ============================================

# Initialize zoxide (smart directory jumping)
# Use 'z' to jump to directories (e.g., 'z project' to jump to ~/projects/my-project)
# Use 'zz' for interactive selection with optional filter
# Note: Using 'zz' instead of 'zi' to avoid conflict with zinit alias
if command -v zoxide &> /dev/null; then
  eval "$(zoxide init zsh --cmd z)"
  # Interactive directory selection with optional query
  zz() {
    local result=$(zoxide query -i "$@")
    if [[ -n "$result" ]]; then
      cd "$result"
    fi
  }
fi

# Enhanced FZF integration
if command -v fzf &> /dev/null; then
  # Setup fzf key bindings and fuzzy completion
  # Ctrl+T - paste selected files and directories
  # Ctrl+R - paste selected command from history
  # Alt+C - cd into selected directory
  
  # Use fd instead of find if available (faster and respects .gitignore)
  if command -v fd &> /dev/null; then
    export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'
  fi
  
  # Use bat for preview if available
  if command -v bat &> /dev/null; then
    export FZF_CTRL_T_OPTS="
      --preview 'bat --color=always --style=numbers --line-range=:500 {}'
      --preview-window 'right:60%:wrap'
    "
  fi
  
  # Beautiful FZF theme
  export FZF_DEFAULT_OPTS="
    --height 60%
    --layout=reverse
    --border
    --inline-info
    --color='fg:#f8f8f2,bg:#282a36,hl:#bd93f9'
    --color='fg+:#f8f8f2,bg+:#44475a,hl+:#bd93f9'
    --color='info:#ffb86c,prompt:#50fa7b,pointer:#ff79c6'
    --color='marker:#ff79c6,spinner:#ffb86c,header:#6272a4'
  "
  
  # Setup FZF keybindings
  source <(fzf --zsh) 2>/dev/null || true
fi

# Initialize thefuck (command corrector)
# Type 'fuck' after a mistake to auto-correct
if command -v thefuck &> /dev/null; then
  eval $(thefuck --alias)
  # Optional: use a less profane alias
  # eval $(thefuck --alias fix)
fi

# Modern CLI tool aliases and integrations
if command -v bat &> /dev/null; then
  alias cat='bat --paging=never'
  alias less='bat --paging=always'
  # Original cat still available as \cat
  export BAT_THEME="Dracula"
fi

if command -v rg &> /dev/null; then
  # ripgrep is already 'rg' command, but add some useful aliases
  alias grep='rg'
  # Original grep still available as \grep
fi

if command -v fd &> /dev/null; then
  # fd is already the command, add an alias for find if desired
  alias find='fd'
  # Original find still available as \find
fi

