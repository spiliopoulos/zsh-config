#!/usr/bin/env bash
# ============================================
# Modern ZSH Configuration - Dependency Installer
# ============================================
# This script installs all required dependencies for the modern zsh setup
# Assumes: macOS with Homebrew installed
# Safe to run multiple times (idempotent)

set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Helper functions
info() {
    echo -e "${BLUE}ℹ${NC} $1"
}

success() {
    echo -e "${GREEN}✓${NC} $1"
}

warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

error() {
    echo -e "${RED}✗${NC} $1"
}

# Check if command exists
command_exists() {
    command -v "$1" &> /dev/null
}

# Check Homebrew
check_homebrew() {
    if ! command_exists brew; then
        error "Homebrew not found. Please install it first:"
        echo "  /bin/bash -c \"\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\""
        exit 1
    fi
    success "Homebrew found"
}

# Install zinit
install_zinit() {
    local zinit_home="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
    
    if [[ -d "$zinit_home" ]]; then
        success "zinit already installed"
        return 0
    fi
    
    info "Installing zinit..."
    bash -c "$(curl --fail --show-error --silent --location https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)" -- -a
    success "zinit installed"
}

# Install zoxide
install_zoxide() {
    if command_exists zoxide; then
        success "zoxide already installed"
        return 0
    fi
    
    info "Installing zoxide..."
    brew install zoxide
    success "zoxide installed"
}

# Install fzf (optional but highly recommended for interactive features)
install_fzf() {
    if command_exists fzf; then
        success "fzf already installed"
        return 0
    fi
    
    info "Installing fzf (fuzzy finder)..."
    brew install fzf
    success "fzf installed"
}

# Install jq (for JSON manipulation)
install_jq() {
    if command_exists jq; then
        success "jq already installed"
        return 0
    fi
    
    info "Installing jq (JSON processor)..."
    brew install jq
    success "jq installed"
}

# Install modern CLI tools
install_modern_tools() {
    local tools=(
        "bat:better cat with syntax highlighting"
        "ripgrep:faster grep (rg)"
        "fd:faster find"
        "vivid:modern LS_COLORS generator"
        "thefuck:command corrector"
        "tldr:simplified man pages"
    )
    
    info "Installing modern CLI tools..."
    
    for tool_info in "${tools[@]}"; do
        IFS=':' read -r tool description <<< "$tool_info"
        
        # Map tool names to command names if different
        local cmd="$tool"
        [[ "$tool" == "ripgrep" ]] && cmd="rg"
        [[ "$tool" == "thefuck" ]] && cmd="fuck"
        
        if command_exists "$cmd"; then
            success "$tool already installed"
        else
            info "Installing $tool ($description)..."
            brew install "$tool"
            success "$tool installed"
        fi
    done
}

# Install Nerd Font for Powerlevel10k
install_fonts() {
    info "Installing Meslo Nerd Font (for Powerlevel10k)..."
    
    brew tap homebrew/cask-fonts 2>/dev/null || true
    
    if brew list --cask font-meslo-lg-nerd-font &>/dev/null; then
        success "Meslo Nerd Font already installed"
    else
        brew install --cask font-meslo-lg-nerd-font
        success "Meslo Nerd Font installed"
        warning "Remember to set your terminal font to 'MesloLGS NF'"
    fi
}

# Main installation
main() {
    echo ""
    echo "╔════════════════════════════════════════════════════════════╗"
    echo "║  Modern ZSH Configuration - Dependency Installer          ║"
    echo "╚════════════════════════════════════════════════════════════╝"
    echo ""
    
    # Check prerequisites
    check_homebrew
    echo ""
    
    # Install dependencies
    info "Installing dependencies..."
    echo ""
    
    install_zinit
    install_zoxide
    install_fzf
    install_jq
    install_modern_tools
    install_fonts
    
    echo ""
    echo "╔════════════════════════════════════════════════════════════╗"
    echo "║  Installation Complete!                                    ║"
    echo "╚════════════════════════════════════════════════════════════╝"
    echo ""
    
    success "All dependencies installed successfully!"
    echo ""
    info "Next steps:"
    echo "  1. Run 'make install' to symlink the zshrc (or run it again if already done)"
    echo "  2. Open a new terminal or run: source ~/.zshrc"
    echo "  3. If using Powerlevel10k for the first time, run: p10k configure"
    echo ""
    info "Terminal font setup (for best visual experience):"
    echo "  • iTerm2: Preferences → Profiles → Text → Font → 'MesloLGS NF'"
    echo "  • Terminal.app: Preferences → Profiles → Font → 'MesloLGS NF'"
    echo "  • VS Code: Settings → Terminal › Integrated: Font Family → 'MesloLGS NF'"
    echo ""
    info "Installed tools:"
    echo "  • zinit      - Fast plugin manager"
    echo "  • zoxide     - Smart directory jumping (use 'z' command)"
    echo "  • fzf        - Fuzzy finder (Ctrl+R for history, Ctrl+T for files)"
    echo "  • jq         - JSON processor"
    echo "  • bat        - Better cat with syntax highlighting"
    echo "  • ripgrep    - Faster grep (use 'rg' command)"
    echo "  • fd         - Faster find"
    echo "  • vivid      - Modern LS_COLORS generator"
    echo "  • thefuck    - Command corrector (type 'fuck' after a mistake)"
    echo "  • tldr       - Simplified man pages"
    echo ""
}

# Run main installation
main
