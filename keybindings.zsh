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

# Cursor shape per vi mode: beam in INSERT, block in NORMAL.
_set_cursor_shape() {
    case $KEYMAP in
        vicmd)         print -n '\e[2 q' ;;  # block
        main|viins|'') print -n '\e[6 q' ;;  # beam
    esac
    zle reset-prompt
}
zle -N zle-keymap-select _set_cursor_shape
zle -N zle-line-init     _set_cursor_shape

# Reset to beam on new prompt (after command runs).
_beam_cursor_precmd() { print -n '\e[6 q'; }
autoload -Uz add-zsh-hook
add-zsh-hook precmd _beam_cursor_precmd
