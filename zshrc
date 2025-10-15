# ============================================
# ZINIT INITIALIZATION
# ============================================
# Set the directory to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Source zinit
source "${ZINIT_HOME}/zinit.zsh"

# ============================================
# ZSH OPTIONS & SETTINGS
# ============================================
# Disable glob pattern failures - allows commands with unmatched patterns to run
unsetopt nomatch

# Disable automatic command correction
unsetopt correctall

# Disable auto directory naming (prevents conflicts with tools like RVM)
unsetopt auto_name_dirs

# Modern navigation and usability options
setopt AUTO_PUSHD           # Push directories onto stack automatically
setopt PUSHD_IGNORE_DUPS    # Don't push duplicates
setopt PUSHD_SILENT         # Don't print stack after pushd/popd
setopt INTERACTIVE_COMMENTS # Allow comments in interactive shell

# History configuration - unlimited with manual cleanup
HISTSIZE=1000000000              # Unlimited history in memory
SAVEHIST=1000000000              # Unlimited history in file
HISTFILE=~/.zsh_history
setopt EXTENDED_HISTORY          # Record timestamp of each command
setopt HIST_IGNORE_ALL_DUPS      # Remove older duplicates
setopt HIST_FIND_NO_DUPS         # Don't show duplicates in search
setopt HIST_IGNORE_SPACE         # Ignore commands starting with space
setopt SHARE_HISTORY             # Share history between sessions

# ============================================
# THEME - Powerlevel10k (Modern, Fast, Async)
# ============================================
# Load Powerlevel10k theme - modern replacement for agnoster
# It has instant prompt and async git status for better performance
zinit ice depth=1
zinit light romkatv/powerlevel10k
zinit ice svn

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ============================================
# PLUGINS - Modern, Fast, Functional
# ============================================

# Load essential completion support
zinit ice wait lucid blockf atpull'zinit creinstall -q .'
zinit light zsh-users/zsh-completions

# Fish-like autosuggestions (type and see suggestions from history)
zinit ice wait lucid atload'_zsh_autosuggest_start'
zinit light zsh-users/zsh-autosuggestions

# Syntax highlighting - must be loaded after compinit and other widgets
# Using the standalone version (faster than OMZ version)
zinit ice wait lucid atinit'zpcompinit; zpcdreplay'
zinit light zsh-users/zsh-syntax-highlighting

# Git plugin for aliases and functions
zinit ice wait lucid
zinit snippet OMZL::git.zsh

zinit ice wait lucid
zinit snippet OMZP::git

# Git extras - additional git commands
zinit ice wait lucid
zinit snippet OMZP::git-extras

# JSON tools - for JSON formatting (or consider using standalone jq)
zinit ice wait lucid
zinit snippet OMZP::jsontools

# Python pip completion
zinit ice wait lucid
zinit snippet OMZP::pip

# Web search from terminal (google, stackoverflow, etc.)
zinit ice wait lucid
zinit snippet OMZP::web-search

# SSH agent management with your specific configuration
zinit ice wait lucid
zinit snippet OMZP::ssh-agent

# Configure SSH agent to forward connections and load your keys
zstyle :omz:plugins:ssh-agent agent-forwarding on
zstyle :omz:plugins:ssh-agent identities hetzner_id_rsa figma_id_ed25519 devbox_id_ed25519

# ============================================
# CUSTOM COLORS - LS_COLORS & SYNTAX HIGHLIGHTING
# ============================================

# Use vivid for modern LS_COLORS if available, otherwise fallback to custom colors
if command -v vivid &> /dev/null; then
  # Use vivid with a modern theme (try different themes: molokai, snazzy, nord, etc.)
  export LS_COLORS="$(vivid generate snazzy)"
else
  # Fallback to custom LS_COLORS if vivid not installed
  LS_COLORS='no=00;32:fi=00:di=00;34:ln=01;36:pi=04;33:so=01;35:bd=33;04:cd=33;04:or=31;01:ex=00;32:'
  LS_COLORS+='*.rtf=00;33:*.txt=00;33:*.html=00;33:*.doc=00;33:*.pdf=00;33:*.ps=00;33:'
  LS_COLORS+='*.sit=00;31:*.hqx=00;31:*.bin=00;31:*.tar=00;31:*.tgz=00;31:*.arj=00;31:'
  LS_COLORS+='*.taz=00;31:*.lzh=00;31:*.zip=00;31:*.z=00;31:*.Z=00;31:*.gz=00;31:'
  LS_COLORS+='*.deb=00;31:*.dmg=00;36:*.jpg=00;35:*.gif=00;35:*.bmp=00;35:*.ppm=00;35:'
  LS_COLORS+='*.tga=00;35:*.xbm=00;35:*.xpm=00;35:*.tif=00;35:*.mpg=00;37:*.avi=00;37:'
  LS_COLORS+='*.gl=00;37:*.dl=00;37:*.mov=00;37:*.mp3=00;35:'
  LS_COLORS+='*.rs=00;33:*.go=00;33:*.ts=00;33:*.tsx=00;33:*.jsx=00;33:*.vue=00;33:'
  LS_COLORS+='*.yml=00;33:*.yaml=00;33:*.toml=00;33:*.json=00;33:*.md=00;33:*.py=00;33:'
  export LS_COLORS
fi

# Apply same colors to tab completion
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# Syntax highlighting styles for command line
ZSH_HIGHLIGHT_STYLES+=(
  default                       'none'
  unknown-token                 'fg=red,bold'
  reserved-word                 'fg=yellow'
  alias                         'fg=none,bold'
  builtin                       'fg=none,bold'
  function                      'fg=none,bold'
  command                       'fg=none,bold'
  hashed-command                'fg=none,bold'
  path                          'fg=cyan'
  globbing                      'fg=cyan'
  history-expansion             'fg=blue'
  single-hyphen-option          'fg=magenta'
  double-hyphen-option          'fg=magenta'
  back-quoted-argument          'fg=magenta,bold'
  single-quoted-argument        'fg=green'
  double-quoted-argument        'fg=green'
  dollar-double-quoted-argument 'fg=cyan'
  back-double-quoted-argument   'fg=cyan'
  assign                        'none'
)

# ============================================
# KEY BINDINGS - Better Terminal Navigation
# ============================================
# Home key - jump to beginning of line
bindkey "\e[H" beginning-of-line
bindkey "^[[H" beginning-of-line

# End key - jump to end of line
bindkey "\e[F" end-of-line
bindkey "^[[F" end-of-line

# Standard Emacs-style word navigation (works everywhere)
# Alt+f - move forward by word
bindkey "^[f" forward-word
bindkey "\ef" forward-word

# Alt+b - move backward by word
bindkey "^[b" backward-word
bindkey "\eb" backward-word

# Ctrl+Left/Right Arrow (for terminals that support it)
bindkey "\e[1;5D" backward-word
bindkey "\e[1;5C" forward-word
bindkey "^[[1;5D" backward-word
bindkey "^[[1;5C" forward-word

# Option+Left/Right Arrow in iTerm2 (if configured as Esc+)
bindkey "\e\e[D" backward-word
bindkey "\e\e[C" forward-word

# Additional useful bindings
bindkey "^A" beginning-of-line  # Ctrl+A
bindkey "^E" end-of-line        # Ctrl+E
bindkey "^K" kill-line          # Ctrl+K - delete to end of line
bindkey "^U" backward-kill-line # Ctrl+U - delete to start of line
bindkey "^W" backward-kill-word # Ctrl+W - delete word backward
bindkey "^Y" yank               # Ctrl+Y - paste (yank)

# ============================================
# ALIASES - Productivity Shortcuts
# ============================================
# Disable shared history between sessions when needed
alias noh="unsetopt sharehistory"

# Disable git prompt and completions for performance in large repos
alias nogit="disable_git_prompt_info; compdef -d git"
alias nog="nogit"

# Vacuum old history - removes entries older than X days
# Usage: vacuum_history 90  (removes entries older than 90 days)
# Usage: vacuum_history 180 (removes entries older than 180 days)
vacuum_history() {
  local days="${1:-90}"  # Default to 90 days if not specified
  local cutoff_timestamp=$(date -v-${days}d +%s 2>/dev/null || date -d "${days} days ago" +%s 2>/dev/null)
  
  if [[ -z "$cutoff_timestamp" ]]; then
    echo "Error: Unable to calculate cutoff date"
    return 1
  fi
  
  local backup_file="${HISTFILE}.backup.$(date +%Y%m%d_%H%M%S)"
  local temp_file="${HISTFILE}.tmp"
  
  echo "📦 Backing up history to: $backup_file"
  cp "$HISTFILE" "$backup_file"
  
  echo "🧹 Removing history entries older than $days days (before $(date -r $cutoff_timestamp '+%Y-%m-%d %H:%M:%S'))..."
  
  # Process the history file
  local removed=0
  local kept=0
  
  while IFS= read -r line; do
    # Check if line starts with timestamp format ': <timestamp>:'
    if [[ "$line" =~ ^:[[:space:]]*([0-9]+):[0-9]+\; ]]; then
      local entry_timestamp="${match[1]}"
      if (( entry_timestamp >= cutoff_timestamp )); then
        echo "$line" >> "$temp_file"
        ((kept++))
      else
        ((removed++))
      fi
    else
      # Keep lines that don't have timestamps (shouldn't happen with EXTENDED_HISTORY)
      echo "$line" >> "$temp_file"
      ((kept++))
    fi
  done < "$HISTFILE"
  
  mv "$temp_file" "$HISTFILE"
  
  echo "✅ Done! Removed $removed entries, kept $kept entries"
  echo "💾 Backup saved to: $backup_file"
  echo "🔄 Reload your shell or run 'fc -R' to reload history"
}

# ============================================
# PATH CONFIGURATION
# ============================================
# Consolidated PATH setup - order matters (highest priority first)
# User binaries -> local node modules -> Homebrew -> system
PATH="$HOME/bin:$HOME/.local/bin:$HOME/node_modules/.bin:/usr/local/bin:/usr/local/sbin:$PATH"
export PATH

# ============================================
# ENVIRONMENT VARIABLES
# ============================================
# Set vim as default editor for git, crontab, etc.
export EDITOR=vim

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

# ============================================
# POWERLEVEL10K CONFIGURATION
# ============================================
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
