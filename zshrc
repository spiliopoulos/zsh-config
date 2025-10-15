# ============================================
# Modern ZSH Configuration
# ============================================
# Main configuration file that sources modular components
# See config/ directory for individual modules

# Detect the directory where this zshrc is located
# This allows the config to work regardless of installation location
# Use ZSH's special parameter expansion to get the path of this file
ZSH_CONFIG_DIR="$(dirname "${(%):-%x}")"

# If the above doesn't work (shouldn't happen), fall back to readlink
if [[ -z "$ZSH_CONFIG_DIR" || "$ZSH_CONFIG_DIR" == "." ]]; then
  if [[ -L "${ZDOTDIR:-$HOME}/.zshrc" ]]; then
    ZSH_CONFIG_DIR="$(dirname "$(readlink "${ZDOTDIR:-$HOME}/.zshrc")")"
  else
    # Last resort: assume we're in the right directory
    ZSH_CONFIG_DIR="${ZDOTDIR:-$HOME}"
  fi
fi

# Config module directory
CONFIG_DIR="${ZSH_CONFIG_DIR}/config"

# ============================================
# LOAD CONFIGURATION MODULES
# ============================================
# Modules are loaded in a specific order for proper initialization

# 1. Initialize zinit (must be first)
[[ -f "${CONFIG_DIR}/init.zsh" ]] && source "${CONFIG_DIR}/init.zsh"

# 2. Set ZSH options and history
[[ -f "${CONFIG_DIR}/options.zsh" ]] && source "${CONFIG_DIR}/options.zsh"

# 3. Load theme (requires zinit)
[[ -f "${CONFIG_DIR}/theme.zsh" ]] && source "${CONFIG_DIR}/theme.zsh"

# 4. Load plugins (requires zinit)
[[ -f "${CONFIG_DIR}/plugins.zsh" ]] && source "${CONFIG_DIR}/plugins.zsh"

# 5. Configure colors (can use plugin features)
[[ -f "${CONFIG_DIR}/colors.zsh" ]] && source "${CONFIG_DIR}/colors.zsh"

# 6. Setup keybindings
[[ -f "${CONFIG_DIR}/keybindings.zsh" ]] && source "${CONFIG_DIR}/keybindings.zsh"

# 7. Load aliases and functions
[[ -f "${CONFIG_DIR}/aliases.zsh" ]] && source "${CONFIG_DIR}/aliases.zsh"

# 8. Setup environment variables and PATH
[[ -f "${CONFIG_DIR}/environment.zsh" ]] && source "${CONFIG_DIR}/environment.zsh"

# 9. Initialize modern tools (requires environment)
[[ -f "${CONFIG_DIR}/tools.zsh" ]] && source "${CONFIG_DIR}/tools.zsh"

# ============================================
# LOCAL CUSTOMIZATION
# ============================================
# Load local customizations if they exist
# This file is not tracked by git - use for machine-specific settings
[[ -f "${CONFIG_DIR}/local.zsh" ]] && source "${CONFIG_DIR}/local.zsh"
