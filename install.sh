#!/usr/bin/env bash

# Zsh Configuration Installer
# This script helps set up the modular zsh configuration

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Helper functions
info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Main installation
main() {
    echo "╔══════════════════════════════════════════╗"
    echo "║   Zsh Configuration Installer            ║"
    echo "╚══════════════════════════════════════════╝"
    echo ""

    # Check prerequisites
    info "Checking prerequisites..."
    
    if ! command_exists zsh; then
        error "Zsh is not installed. Please install zsh first."
        exit 1
    fi
    success "Zsh found: $(zsh --version)"

    if ! command_exists git; then
        error "Git is not installed. Please install git first."
        exit 1
    fi
    success "Git found: $(git --version | head -n1)"

    echo ""

    # Check optional dependencies
    info "Checking optional dependencies..."
    
    command_exists fzf && success "FZF found" || warning "FZF not found (recommended)"
    command_exists zoxide && success "Zoxide found" || warning "Zoxide not found (recommended)"
    command_exists nvim && success "Neovim found" || warning "Neovim not found (recommended)"
    command_exists nvm && success "NVM found" || warning "NVM not found (optional)"
    command_exists conda && success "Conda found" || warning "Conda not found (optional)"
    command_exists go && success "Go found" || warning "Go not found (optional)"

    echo ""

    # Get script directory
    SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
    CONFIG_DIR="$HOME/.config/zsh"
    ZSHRC_PATH="$HOME/.zshrc"

    # Backup existing .zshrc
    if [ -f "$ZSHRC_PATH" ] && [ ! -L "$ZSHRC_PATH" ]; then
        info "Backing up existing .zshrc to .zshrc.backup"
        cp "$ZSHRC_PATH" "$ZSHRC_PATH.backup"
        success "Backup created"
    fi

    # Create config directory if it doesn't exist
    if [ ! -d "$CONFIG_DIR" ]; then
        info "Creating config directory: $CONFIG_DIR"
        mkdir -p "$CONFIG_DIR"
    fi

    # Copy configuration files
    info "Installing configuration files..."
    
    if [ "$SCRIPT_DIR" != "$CONFIG_DIR" ]; then
        cp -r "$SCRIPT_DIR"/*.zsh "$CONFIG_DIR/" 2>/dev/null || true
        cp "$SCRIPT_DIR/README.md" "$CONFIG_DIR/" 2>/dev/null || true
        cp "$SCRIPT_DIR/zshrc.local.example" "$CONFIG_DIR/" 2>/dev/null || true
        success "Configuration files copied"
    else
        success "Already in config directory"
    fi

    # Install .zshrc
    info "Installing .zshrc..."
    cp "$SCRIPT_DIR/.zshrc" "$ZSHRC_PATH"
    success ".zshrc installed"

    # Install Powerlevel10k if not present
    P10K_DIR="$HOME/powerlevel10k"
    P10K_ALT_DIR="$HOME/.local/share/powerlevel10k"
    
    if [ ! -d "$P10K_DIR" ] && [ ! -d "$P10K_ALT_DIR" ]; then
        info "Powerlevel10k not found. Installing to ~/powerlevel10k..."
        git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$P10K_DIR"
        success "Powerlevel10k installed"
    else
        success "Powerlevel10k already installed"
    fi

    # Create local config example
    LOCAL_CONFIG="$HOME/.zshrc.local"
    if [ ! -f "$LOCAL_CONFIG" ]; then
        info "Creating example local config..."
        cp "$CONFIG_DIR/zshrc.local.example" "$LOCAL_CONFIG"
        success "Created ~/.zshrc.local (edit this for machine-specific settings)"
    else
        warning "~/.zshrc.local already exists, skipping"
    fi

    echo ""
    echo "╔══════════════════════════════════════════╗"
    echo "║         Installation Complete!           ║"
    echo "╚══════════════════════════════════════════╝"
    echo ""
    info "Next steps:"
    echo "  1. Restart your shell: exec zsh"
    echo "  2. On first launch, Zinit will auto-install plugins"
    echo "  3. Configure Powerlevel10k: p10k configure"
    echo "  4. Edit ~/.zshrc.local for machine-specific settings"
    echo ""
    
    if ! command_exists fzf || ! command_exists zoxide; then
        warning "Recommended tools not installed:"
        ! command_exists fzf && echo "  - FZF: brew install fzf  (or your package manager)"
        ! command_exists zoxide && echo "  - Zoxide: brew install zoxide"
        echo ""
    fi

    success "Enjoy your new zsh configuration! 🚀"
}

# Run main function
main "$@"
