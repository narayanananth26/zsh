# Environment variables and PATH configuration

# Add local bin to PATH
export PATH="/usr/local/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

export NVM_DIR="$HOME/.nvm"
   # Lazy load nvm
   nvm() {
       unset -f nvm
       [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
       nvm "$@"
   }

# Go configuration
if command -v go &> /dev/null; then
    export GOPATH=$HOME/go
    export PATH=$PATH:$GOPATH/bin
    export PATH=$PATH:$(go env GOPATH)/bin
fi

# Lazy-load Conda only when needed
conda() {
    unset -f conda
    # Try different conda paths
    if [ -f "/opt/anaconda3/bin/conda" ]; then
        __conda_setup="$('/opt/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
        if [ $? -eq 0 ]; then
            eval "$__conda_setup"
        fi
    elif [ -f "$HOME/anaconda3/bin/conda" ]; then
        __conda_setup="$('$HOME/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
        if [ $? -eq 0 ]; then
            eval "$__conda_setup"
        fi
    elif [ -f "$HOME/miniconda3/bin/conda" ]; then
        __conda_setup="$('$HOME/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
        if [ $? -eq 0 ]; then
            eval "$__conda_setup"
        fi
    fi
    unset __conda_setup
    conda "$@"
}
