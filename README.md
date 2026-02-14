# Zsh Configuration

A modular, well-organized zsh configuration that's easy to customize and share.

## Features

- **Vi mode** with enhanced keybindings
- **Smart history** with search and deduplication
- **Powerlevel10k** theme
- **Plugin management** with Zinit
- **Syntax highlighting** and autosuggestions
- **FZF integration** for fuzzy finding
- **Zoxide** for smart directory jumping
- **Custom functions** for C/C++ compilation and web searches
- **Git integration** with Oh My Zsh plugins

## Prerequisites

### Required

- [Zsh](https://www.zsh.org/) (shell)
- [Git](https://git-scm.com/) (for plugin installation)

### Recommended

- [Powerlevel10k](https://github.com/romkatv/powerlevel10k) (theme)
- [FZF](https://github.com/junegunn/fzf) (fuzzy finder)
- [Zoxide](https://github.com/ajeetdsouza/zoxide) (smart cd)
- [Neovim](https://neovim.io/) (for vim/vi aliases)

### Optional

- [NVM](https://github.com/nvm-sh/nvm) (Node version manager)
- [Conda](https://docs.conda.io/) (Python environment manager)
- [Go](https://golang.org/) (Go programming language)

## Installation

### 1. Clone the repository

```bash
git clone https://github.com/narayanananth26/zsh.git ~/.config/zsh
```

### 2. Backup your existing config

```bash
mv ~/.zshrc ~/.zshrc.backup
```

This might throw an error: No such file or directory (that's ok)

### 3. Create symlinks

```bash
ln -s ~/.config/zsh/.zshrc ~/.zshrc
ln -s ~/.config/zsh/zsh ~/.config/zsh
```

### 4. Install Powerlevel10k

```bash
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
```

Or install to `~/.local/share/powerlevel10k/`:

```bash
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.local/share/powerlevel10k
```

### 5. Install recommended tools

#### macOS (Homebrew)

```bash
brew install fzf zoxide neovim
```

#### Linux (Ubuntu/Debian)

```bash
sudo apt install fzf zoxide neovim
```

### 6. Restart your shell

```bash
exec zsh
```

On first launch, Zinit will automatically install all plugins.

## Configuration Structure

```
~/.config/zsh/
├── environment.zsh    # Environment variables and PATH
├── history.zsh        # History settings
├── keybindings.zsh    # Keyboard shortcuts
├── plugins.zsh        # Plugin manager and plugins
├── completion.zsh     # Completion configuration
├── functions.zsh      # Custom shell functions
├── aliases.zsh        # Command aliases
├── theme.zsh          # Powerlevel10k theme
├── tools.zsh          # External tools (fzf, zoxide)
└── zshrc.local.example # Example local config
```

## Customization

### Local overrides

Create a `~/.zshrc.local` file for machine-specific settings:

```bash
cp ~/.config/zsh/zshrc.local.example ~/.zshrc.local
```

This file is not tracked in git and is perfect for:

- Private API keys
- Machine-specific paths
- Work-related configurations
- Personal aliases

### Modifying modules

Each module can be edited independently:

- **Add aliases**: Edit `~/.config/zsh/aliases.zsh`
- **Add functions**: Edit `~/.config/zsh/functions.zsh`
- **Change keybindings**: Edit `~/.config/zsh/keybindings.zsh`
- **Add plugins**: Edit `~/.config/zsh/plugins.zsh`

## Custom Functions

### Compilation helpers

```bash
# Compile and run C++ file with C++17
g++ main.cpp -r

# Compile and run C file with C11
gcc program.c -r
```

### Web search shortcuts

```bash
# Google search
google "search query"

# Open localhost
google local 3000

# Open URL
google -u example.com

# DuckDuckGo search
ddg "search query"

# StackOverflow search
so "how to use zsh"
```

## Keybindings

- `Ctrl+R` - Reverse history search
- `Ctrl+J` - Search backward in history
- `Ctrl+K` - Search forward in history
- Vi mode enabled by default

## Updating

```bash
cd ~/.config/zsh
git pull
```

Then restart your shell:

```bash
exec zsh
```

## Uninstallation

```bash
# Remove symlinks
rm ~/.zshrc
rm -rf ~/.config/zsh

# Restore backup
mv ~/.zshrc.backup ~/.zshrc

# Remove plugins and theme (optional)
rm -rf ~/.local/share/zinit
rm -rf ~/powerlevel10k
```

## Troubleshooting

### Plugins not loading

```bash
# Reinstall zinit
rm -rf ~/.local/share/zinit
exec zsh
```

### Theme not showing

```bash
# Reconfigure Powerlevel10k
p10k configure
```

### Command not found

Check if the tool is installed:

```bash
which zoxide fzf nvim
```

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

MIT License - feel free to use and modify as needed.

## Credits

- [Zinit](https://github.com/zdharma-continuum/zinit) - Plugin manager
- [Powerlevel10k](https://github.com/romkatv/powerlevel10k) - Theme
- [Oh My Zsh](https://ohmyz.sh/) - Git plugins and libraries
- [zsh-users](https://github.com/zsh-users) - Completions, syntax highlighting, autosuggestions
