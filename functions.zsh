# Custom functions

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
