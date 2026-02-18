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
    
    # Check if an alias exists for this command
    local alias_matches=$(alias | grep -E "='.*${cmd}.*'" | head -5)
    
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
