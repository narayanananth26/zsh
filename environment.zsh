# Interactive-shell-only environment setup.
# Pure exports (PATH, GOPATH, NVM_DIR, PNPM_HOME) live in ~/.zshenv so scripts
# and GUI-launched processes see them too. Only lazy-loaders belong here.

# Lazy load nvm
nvm() {
    unset -f nvm
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    nvm "$@"
}

# Append Go's reported GOPATH/bin once go is present (interactive convenience).
if command -v go &> /dev/null; then
    export PATH="$PATH:$(go env GOPATH)/bin"
fi

# Lazy-load Conda only when needed
conda() {
    unset -f conda
    if [ -f "/opt/anaconda3/bin/conda" ]; then
        __conda_setup="$('/opt/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
        [ $? -eq 0 ] && eval "$__conda_setup"
    elif [ -f "$HOME/anaconda3/bin/conda" ]; then
        __conda_setup="$('$HOME/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
        [ $? -eq 0 ] && eval "$__conda_setup"
    elif [ -f "$HOME/miniconda3/bin/conda" ]; then
        __conda_setup="$('$HOME/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
        [ $? -eq 0 ] && eval "$__conda_setup"
    fi
    unset __conda_setup
    conda "$@"
}
