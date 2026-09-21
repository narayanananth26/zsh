# Completion configuration

# Local completion functions (e.g. herdr) — must precede compinit
fpath=("${ZSH_CONFIG_DIR:-$HOME/.config/zsh}/completions" $fpath)
fpath=(/opt/homebrew/share/zsh/site-functions $fpath)

# Completion configuration with aggressive caching
autoload -Uz compinit

# Only regenerate compdump once per day
if [[ -n ~/.zcompdump(#qN.mh-24) ]]; then
  compinit -C
else
  compinit
fi

autoload -Uz bashcompinit && bashcompinit
complete -C '/usr/local/bin/aws_completer' aws

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no 
zstyle ':fzf-tab:complete:z:*' fzf-preview 'ls --color $realpath'
