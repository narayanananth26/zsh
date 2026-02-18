# Theme configuration

# Powerlevel10k theme - check multiple possible locations
if [[ -f ~/powerlevel10k/powerlevel10k.zsh-theme ]]; then
    source ~/powerlevel10k/powerlevel10k.zsh-theme
elif [[ -f ~/.local/share/powerlevel10k/powerlevel10k.zsh-theme ]]; then
    source ~/.local/share/powerlevel10k/powerlevel10k.zsh-theme
elif [[ -f /usr/local/share/powerlevel10k/powerlevel10k.zsh-theme ]]; then
    source /usr/local/share/powerlevel10k/powerlevel10k.zsh-theme
fi

# Load p10k configuration
# Try config directory first, fall back to home directory
if [[ -f ~/.config/zsh/p10k.zsh ]]; then
    source ~/.config/zsh/p10k.zsh
elif [[ -f ~/.p10k.zsh ]]; then
    source ~/.p10k.zsh
fi

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/p10k.zsh
