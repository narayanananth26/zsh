# Completion configuration

# Local completion functions (e.g. herdr) — must precede compinit
fpath=("${ZSH_CONFIG_DIR:-$HOME/.config/zsh}/completions" $fpath)

# Completion configuration with aggressive caching
autoload -Uz compinit

# Only regenerate compdump once per day
for dump in ~/.zcompdump(N.mh+24); do
  compinit
done
if [[ ! -e ~/.zcompdump ]]; then
  compinit
else
  compinit -C
fi

autoload -Uz bashcompinit && bashcompinit
complete -C '/usr/local/bin/aws_completer' aws

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no 
zstyle ':fzf-tab:complete:z:*' fzf-preview 'ls --color $realpath'
