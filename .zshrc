# Main zsh configuration file
# This file sources modular configuration files from ~/.config/zsh/

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Set configuration directory
ZSH_CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"


# Source configuration modules
source "$ZSH_CONFIG_DIR/environment.zsh"
source "$ZSH_CONFIG_DIR/history.zsh"
source "$ZSH_CONFIG_DIR/keybindings.zsh"
source "$ZSH_CONFIG_DIR/plugins.zsh"
source "$ZSH_CONFIG_DIR/completion.zsh"
source "$ZSH_CONFIG_DIR/functions.zsh"
source "$ZSH_CONFIG_DIR/aliases.zsh"
source "$ZSH_CONFIG_DIR/theme.zsh"
source "$ZSH_CONFIG_DIR/tools.zsh"


# Enable aliases
setopt aliases

# Source local machine-specific overrides (not tracked in git)
# Copy zshrc.local.example to ~/.zshrc.local and customize
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local
