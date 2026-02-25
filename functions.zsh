# Custom functions

# FZF Alias Finder - Ctrl+A to search
fzf-alias() {
    local selected
    # Get all aliases with their definitions
    selected=$(alias | fzf --height 40% --reverse --border \
        --preview 'echo {}' \
        --preview-window down:3:wrap \
        --header 'Search aliases (Enter to insert, Esc to cancel)')
    
    if [[ -n "$selected" ]]; then
        # Extract just the alias name (before the '=')
        local alias_name="${selected%%=*}"
        # Insert it into the command line
        LBUFFER="${LBUFFER}${alias_name}"
    fi
    zle reset-prompt
}

# Register as a ZLE widget and bind to Ctrl+A
zle -N fzf-alias
bindkey '^a' fzf-alias

# Alias Reminder - Shows when alias exists
# This runs before each command and checks if you could have used an alias
alias_reminder() {
    # Only check if not in completion mode
    [[ -n $ZSH_EVAL_CONTEXT && $ZSH_EVAL_CONTEXT =~ :file$ ]] && return
    
    local cmd="$1"
    # Skip if empty or starts with alias itself
    [[ -z "$cmd" || "$cmd" == alias* ]] && return
    
    # Only grep if cmd doesn't contain problematic characters
    if [[ "$cmd" =~ ^[a-zA-Z0-9_-]+$ ]]; then
        local alias_matches=$(alias | grep -E "='.*${cmd}.*'" 2>/dev/null | head -5)
    fi
    
    if [[ -n "$alias_matches" ]]; then
        echo -e "\033[33m💡 Alias available:\033[0m"
        echo "$alias_matches" | sed 's/^/   /'
    fi
}

# Hook into preexec (runs before each command)
autoload -Uz add-zsh-hook
add-zsh-hook preexec alias_reminder


# Quick Alias Search Function
# Usage: falias <search-term>
# Example: falias git, falias status, falias push
falias() {
    if [[ -z "$1" ]]; then
        echo "Usage: falias <search-term>"
        echo "Example: falias git"
        return 1
    fi
    
    echo -e "\033[36m🔍 Aliases matching '$1':\033[0m"
    alias | grep -i "$1" | sort
}

# List all git aliases
galias() {
    echo -e "\033[36m📋 All Git Aliases:\033[0m"
    alias | grep -E "^g[a-z]*=" | sort
}

# Enhanced g++ wrapper with compile and run option
unalias g++ 2>/dev/null

g++() {
    # Only act if the first argument is a .cpp file
    if [[ "$1" == *.cpp ]]; then
        filename="${1%.*}"
        shift # remove the cpp file argument

        run_exec=false
        args=()

        # Parse remaining arguments
        for arg in "$@"; do
            if [[ "$arg" == "-r" || "$arg" == "--run" ]]; then
                run_exec=true
            else
                args+=("$arg")
            fi
        done

        # Compile with C++17
        command g++ -std=c++17 "${filename}.cpp" -o "$filename" "${args[@]}"

        # Run the executable if -r or --run was provided
        if $run_exec; then
            echo "========== $filename.cpp =========="
            ./"$filename"
        fi
    else
        # Default behavior for other files
        command g++ "$@"
    fi
}

# Enhanced gcc wrapper with compile and run option
unalias gcc 2>/dev/null

gcc() {
    # Only act if the first argument is a .c file
    if [[ "$1" == *.c ]]; then
        filename="${1%.*}"
        shift # remove the c file argument

        run_exec=false
        args=()

        # Parse remaining arguments
        for arg in "$@"; do
            if [[ "$arg" == "-r" || "$arg" == "--run" ]]; then
                run_exec=true
            else
                args+=("$arg")
            fi
        done

        # Compile with C11 standard
        command gcc -std=c11 "${filename}.c" -o "$filename" "${args[@]}"

        # Run the executable if -r or --run was provided
        if $run_exec; then
            echo "========== $filename =========="
            ./"$filename"
        fi
    else
        # Default behavior for other files
        command gcc "$@"
    fi
}

# Check which dev tools are installed — run this before editing ~/.zshrc.local
check-tools() {
    local green="\033[32m" yellow="\033[33m" bold="\033[1m" reset="\033[0m"

    local search_dirs=(
        ~/.local/bin ~/.local/share/pdm/bin
        /opt/homebrew/bin /opt/homebrew/sbin
        /usr/local/bin /usr/bin /bin
        ~/anaconda3/bin ~/miniconda3/bin /opt/anaconda3/bin
        ~/.pyenv/bin ~/.pyenv/shims
        ~/.cargo/bin ~/.bun/bin
        ~/go/bin ~/Library/pnpm ~/.pnpm/bin
        ~/.nvm/versions/node/*/bin(N)
    )

    _ct_check() {
        local cmd="$1"
        local found_path=""
        local in_path=false
        local lazy=false

        # 1. Real binary in current PATH
        found_path=$(whence -p "$cmd" 2>/dev/null)
        if [[ -n "$found_path" ]]; then
            in_path=true
        fi

        # 2. Lazy-loaded shell function (nvm, conda, etc.)
        if [[ -z "$found_path" ]] && command -v "$cmd" &>/dev/null; then
            lazy=true
        fi

        # 3. Search known install dirs when not in PATH
        if [[ -z "$found_path" ]]; then
            for dir in $search_dirs; do
                if [[ -x "$dir/$cmd" ]]; then
                    found_path="$dir/$cmd"
                    break
                fi
            done
        fi

        if $in_path; then
            printf "  ${green}✓${reset} %-12s %s\n" "$cmd" "$found_path"
        elif [[ -n "$found_path" ]] && $lazy; then
            printf "  ${green}✓${reset} %-12s %s ${yellow}(lazy-loaded)${reset}\n" "$cmd" "$found_path"
        elif [[ -n "$found_path" ]]; then
            printf "  ${yellow}!${reset} %-12s %s ${yellow}(not in PATH — add to ~/.zshrc.local)${reset}\n" "$cmd" "$found_path"
        elif $lazy; then
            printf "  ${green}✓${reset} %-12s %s\n" "$cmd" "(lazy-loaded shell function)"
        fi
    }

    echo -e "\n${bold}Installed dev tools:${reset}"

    echo -e "\n${yellow}Python${reset}"
    _ct_check "python"  python3
    _ct_check "pip"     pip3
    _ct_check "pdm"     pdm
    _ct_check "uv"      uv
    _ct_check "pyenv"   pyenv
    _ct_check "conda"   conda
    _ct_check "poetry"  poetry
    _ct_check "pipx"    pipx

    echo -e "\n${yellow}Node / JS${reset}"
    _ct_check "node"    node
    _ct_check "npm"     npm
    _ct_check "pnpm"    pnpm
    _ct_check "yarn"    yarn
    _ct_check "bun"     bun
    _ct_check "deno"    deno

    echo -e "\n${yellow}Rust${reset}"
    _ct_check "cargo"   cargo
    _ct_check "rustup"  rustup

    echo -e "\n${yellow}Go${reset}"
    _ct_check "go"      go

    echo -e "\n${yellow}Package managers${reset}"
    _ct_check "brew"    brew
    _ct_check "apt"     apt
    _ct_check "nix"     nix

    echo -e "\n${yellow}Shell tools${reset}"
    _ct_check "fzf"     fzf
    _ct_check "zoxide"  zoxide
    _ct_check "tmux"    tmux
    _ct_check "nvim"    nvim
    _ct_check "git"     git
    _ct_check "docker"  docker
    _ct_check "gh"      gh

    echo -e "\n${bold}To add missing tools to your PATH:${reset}"
    echo -e "  Edit ${yellow}~/.zshrc.local${reset} and uncomment the relevant lines."
    echo -e "  Then run: ${yellow}source ~/.zshrc.local${reset}\n"

    unfunction _ct_check
}

# Open Google search or localhost in browser
google() {
    if [[ "$1" = "local" && -n "$2" ]]; then
        open "http://localhost:$2"
    elif [[ "$1" = "-u" && -n "$2" ]]; then
        open "https://$2"
    else
        local query="${*// /+}"
        open "https://www.google.com/search?q=${query}"
    fi
}

# DuckDuckGo search
ddg() {
    local query="${*// /+}"
    open "https://duckduckgo.com/?q=${query}"
}

# StackOverflow search
so() {
    local query="${*// /+}"
    open "https://stackoverflow.com/search?q=${query}"
}
