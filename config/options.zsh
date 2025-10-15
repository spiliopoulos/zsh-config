# ============================================
# ZSH OPTIONS & SETTINGS
# ============================================

# Disable problematic defaults
unsetopt nomatch          # Allow unmatched patterns to pass through
unsetopt correctall       # Don't auto-correct commands
unsetopt auto_name_dirs   # Prevent conflicts with tools like RVM

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

