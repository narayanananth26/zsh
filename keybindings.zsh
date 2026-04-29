# Keybindings

# Enable vi mode
bindkey -v

# History search
bindkey '^R' history-incremental-search-backward
bindkey '^j' history-search-backward
bindkey '^k' history-search-forward

# Vi text objects: ci" ci' ci` ci( ci[ ci{ ci< cit, plus ci/ca variants.
autoload -Uz select-bracketed select-quoted
zle -N select-bracketed
zle -N select-quoted
for km in viopp visual; do
    bindkey -M $km -- '-' vi-up-line-or-history
    for c in {a,i}${(s..)^:-\'\"\`\|,./:;=+@}; do
        bindkey -M $km $c select-quoted
    done
    for c in {a,i}${(s..)^:-'()[]{}<>bB'}; do
        bindkey -M $km $c select-bracketed
    done
done

