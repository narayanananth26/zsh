# Super based Zsh config

## Features

- **Blazingly Fast Startup** - Optimized to ~150-200ms with lazy loading
- **Vi mode** with enhanced keybindings
- **Smart history** with search and deduplication
- **Powerlevel10k** theme with instant prompt
- **Plugin management** with Zinit (turbo mode enabled)
- **Syntax highlighting** and autosuggestions (lazy loaded)
- **FZF integration** for fuzzy finding
- `Ctrl+A` - Interactive alias search
- **Zoxide** for smart directory jumping
- **60+ Git aliases** - Custom, fast git shortcuts
- **Alias discovery tools** - Find and learn your aliases
- **Smart caching** - Completions, tools, and initializations
- **Lazy loading** - NVM, Conda, and other slow tools
- **Custom functions** for C/C++ compilation and web searches

## Performance Optimizations

This configuration is highly optimized for fast shell startup:

### Lazy Loading

- **NVM** - Only loaded when you first use `nvm` command
- **Conda** - Only loaded when you first use `conda` command
- **Zoxide** - Initialization cached to `~/.cache/zoxide-init.zsh`

### Completion Caching

- Completions are cached for 24 hours
- Regenerates only when cache expires
- Saves ~300-500ms on every shell startup

### Plugin Turbo Mode

All non-essential plugins load asynchronously after prompt appears:

- zsh-syntax-highlighting
- zsh-autosuggestions
- fzf-tab

### Startup Time

Test your startup time:

```bash
time zsh -i -c exit
```

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
# Backup if .zshrc exists (might show "No such file" - that's fine, DO NOT PANIC!)
mv ~/.zshrc ~/.zshrc.backup 2>/dev/null || true
```

### 3. Copy the main config file

```bash
cp ~/.config/zsh/.zshrc ~/.zshrc
```

### 4. Install Powerlevel10k

```bash
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
```

Or install to `~/.local/share/powerlevel10k/`:

```bash
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.local/share/powerlevel10k
```

**Note:** The included `p10k.zsh` configuration will give you the exact prompt style used in this setup. You can customize it later by running `p10k configure`.

### 5. Install recommended tools

#### macOS (Homebrew)

```bash
brew install fzf zoxide neovim
```

#### Linux (Ubuntu/Debian)

```bash
sudo apt install fzf zoxide neovim
```

### 6. Set up local overrides

```bash
# 1. Create your local config file
cp ~/.config/zsh/zshrc.local.example ~/.zshrc.local

# 2. Restart your shell so the new function is available
exec zsh

# 3. See which tools you already have installed
check-tools
```

`check-tools` will print every installed tool and its path. Open `~/.zshrc.local` and uncomment the lines for tools that are missing from the output. This file is **not tracked in git** and is the right place for machine-specific paths, private API keys, and personal aliases.

### 7. Configure for login shells (macOS/most terminals)

```bash
# Add this to ~/.zprofile to load .zshrc on startup
echo '[[ -f ~/.zshrc ]] && source ~/.zshrc' >> ~/.zprofile
```

### 8. Restart your shell

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
├── p10k.zsh           # Powerlevel10k configuration (prompt style)
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
- **Customize prompt**: Run `p10k configure` or edit `~/.config/zsh/p10k.zsh`

## Git Aliases

60+ custom git aliases for faster workflow (no Oh-My-Zsh dependency):

### Most Used

```bash
g      # git
gst/gs # git status
ga     # git add
gaa    # git add --all
gc     # git commit -v
gcm    # git commit -m
gcam   # git commit -a -m
gp     # git push
gl     # git pull
gd     # git diff
gco    # git checkout
gcb    # git checkout -b
gb     # git branch
```

### Advanced

```bash
gpsup  # git push and set upstream
gpf    # git push --force-with-lease
grbi   # git rebase -i
glola  # beautiful git log graph
gsta   # git stash
grh    # git reset
grhh   # git reset --hard
groh   # git reset origin/<current-branch> --hard
```

See all aliases: `galias` or search: `falias <keyword>`

## Alias Discovery & Search

### Interactive FZF Alias Finder

Press `Ctrl+A` anywhere to search through all your aliases with fuzzy finding.

### Smart Alias Reminder

Automatically shows you available aliases when you type full commands:

```bash
$ git status
💡 Alias available:
   gs='git status'
   gst='git status'
```

### Search Functions

```bash
# Search for aliases by keyword
falias push
# Shows: gp, gpf, gpsup, etc.

# List all git aliases
galias

# Browse all aliases with pagination
aliases
```

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

### Aliases not working (ta, xx, vi, etc.)

If your aliases don't work after installation:

```bash
# Check if .zprofile loads .zshrc
cat ~/.zprofile | grep zshrc

# If nothing shows, add this line:
echo '[[ -f ~/.zshrc ]] && source ~/.zshrc' >> ~/.zprofile

# Then restart your terminal
```

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

# Or to use the included configuration:
cp ~/.config/zsh/p10k.zsh ~/.p10k.zsh
exec zsh
```

### A tool I had installed is no longer found

Run `check-tools` — it scans for all common dev tools and prints their paths:

```bash
check-tools
```

Any tool that's missing from the output isn't in your PATH. Open `~/.zshrc.local`, uncomment (or add) the relevant `export PATH` line, then reload:

```bash
source ~/.zshrc.local
```

If you're not sure where a tool was installed, search for it:

```bash
find ~/.local/bin ~/.cargo/bin ~/.bun/bin /usr/local/bin /opt/homebrew/bin -name "pdm" 2>/dev/null
```

Common install locations:

| Tool | Typical binary location |
|------|------------------------|
| pdm | `~/.local/bin/` or `~/.local/share/pdm/bin/` |
| pyenv | `~/.pyenv/bin/` |
| cargo / rust tools | `~/.cargo/bin/` |
| bun | `~/.bun/bin/` |
| pnpm | `~/Library/pnpm/` (macOS) or `~/.local/share/pnpm/` |
| go binaries | `~/go/bin/` |
| Homebrew (Apple Silicon) | `/opt/homebrew/bin/` |
| Homebrew (Intel Mac) | `/usr/local/bin/` |

### "defining function based on alias" error in tmux

This happens when old aliases conflict with new functions. Solutions:

```bash
# Option 1: Kill tmux server and restart fresh
tmux kill-server
tmux

# Option 2: In the affected tmux pane
unalias gpsup 2>/dev/null
source ~/.zshrc
```

This occurs because tmux-resurrect restores old shell environments.

### Slow startup time

Check your startup time:

```bash
time zsh -i -c exit
```

Should be under 200ms. If slower:

1. Make sure lazy loading is working (check environment.zsh)
2. Clear completion cache: `rm ~/.zcompdump*`
3. Profile with `zprof`: Add `zmodload zsh/zprof` to top of .zshrc and `zprof` at bottom

## Credits

- [Zinit](https://github.com/zdharma-continuum/zinit) - Plugin manager
- [Powerlevel10k](https://github.com/romkatv/powerlevel10k) - Theme
- [zsh-users](https://github.com/zsh-users) - Completions, syntax highlighting, autosuggestions
- [FZF](https://github.com/junegunn/fzf) - Fuzzy finder
- [Zoxide](https://github.com/ajeetdsouza/zoxide) - Smart directory navigation
