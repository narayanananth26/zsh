# External tools configuration

# Zoxide - smarter cd command (cached)
if command -v zoxide &> /dev/null; then
    # Cache zoxide init to avoid regenerating every time
    if [[ ! -f ~/.cache/zoxide-init.zsh ]] || [[ $(command -v zoxide) -nt ~/.cache/zoxide-init.zsh ]]; then
        mkdir -p ~/.cache
        zoxide init zsh > ~/.cache/zoxide-init.zsh
    fi
    source ~/.cache/zoxide-init.zsh
fi

# FZF - fuzzy finder
if command -v fzf &>/dev/null; then
    eval "$(fzf --zsh)"
elif [ -f ~/.fzf.zsh ]; then
    source ~/.fzf.zsh
fi
