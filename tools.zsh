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

# FZF - fuzzy finder - lazy load keybindings
if [ -f ~/.fzf.zsh ]; then
    # Only source completions immediately, defer keybindings
    source <(grep -v 'bindkey' ~/.fzf.zsh)
    
    # Load keybindings on first use
    _fzf_lazy_load() {
        unfunction _fzf_lazy_load
        source <(grep 'bindkey' ~/.fzf.zsh)
    }
    zle -N zle-line-init _fzf_lazy_load
fi
