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

# Clear Ruby optimization variable to avoid conflicts
unset RUBYOPT

