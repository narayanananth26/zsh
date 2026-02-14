# Completion configuration

# Initialize completions
autoload -Uz compinit
compinit -u

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no 
zstyle ':fzf-tab:complete:z:*' fzf-preview 'ls --color $realpath'
