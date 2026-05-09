# Super Based Zsh Config

## Required

- [zsh](https://www.zsh.org/) (shell)
- [git](https://git-scm.com/) (for plugin installation)

## Recommended

- [powerlevel10k](https://github.com/romkatv/powerlevel10k) (theme)
- [fzf](https://github.com/junegunn/fzf) (fuzzy finder)
- [zoxide](https://github.com/ajeetdsouza/zoxide) (smart cd)
- [neovim](https://neovim.io/) (for vim/vi aliases)

## Optional

- [nvm](https://github.com/nvm-sh/nvm) (node version manager)
- [conda](https://docs.conda.io/) (python environment manager)
- [go](https://golang.org/) (go programming language)

## Installation

### 1. Clone the repository

```bash
git clone https://github.com/narayanananth26/zsh.git ~/.config/zsh
```

### 2. Backup your existing config

```bash
# backup if .zshrc exists (might show "no such file" - that's fine, do not panic!)
mv ~/.zshrc ~/.zshrc.backup 2>/dev/null || true
```

### 3. Copy the main config file

```bash
cp ~/.config/zsh/.zshrc ~/.zshrc
```

### 4. Install powerlevel10k

```bash
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
```

or install to `~/.local/share/powerlevel10k/`:

```bash
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.local/share/powerlevel10k
```

**note:** the included `p10k.zsh` configuration will give you the exact prompt style used in this setup. you can customize it later by running `p10k configure`.

### 5. Install recommended tools

#### MacOS (homebrew)

```bash
brew install fzf zoxide neovim
```

#### Linux (Ubuntu/Debian)

```bash
sudo apt install fzf zoxide neovim
```

### 6. Set up local overrides

```bash
cp ~/.config/zsh/zshrc.local.example ~/.zshrc.local
```

open `~/.zshrc.local` and uncomment the lines for tools you have installed. this file is **not tracked in git** and is the right place for machine-specific paths, private api keys, personal aliases, and work-related configurations.

### 7. Restart your shell

```bash
exec zsh
```
