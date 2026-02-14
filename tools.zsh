# External tools configuration

# Zoxide - smarter cd command
if command -v zoxide &> /dev/null; then
    eval "$(zoxide init zsh)"
fi

# FZF - fuzzy finder
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
