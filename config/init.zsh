# ============================================
# ZINIT INITIALIZATION
# ============================================
# Initialize zinit plugin manager
# Must be loaded first before any plugins

# Set the directory to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Source zinit
if [[ -f "${ZINIT_HOME}/zinit.zsh" ]]; then
  source "${ZINIT_HOME}/zinit.zsh"
else
  echo "⚠️  zinit not found. Run: ./install-dependencies.sh"
fi

