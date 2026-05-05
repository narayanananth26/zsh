# super based zsh config

## required

- [zsh](https://www.zsh.org/) (shell)
- [git](https://git-scm.com/) (for plugin installation)

## recommended

- [powerlevel10k](https://github.com/romkatv/powerlevel10k) (theme)
- [fzf](https://github.com/junegunn/fzf) (fuzzy finder)
- [zoxide](https://github.com/ajeetdsouza/zoxide) (smart cd)
- [neovim](https://neovim.io/) (for vim/vi aliases)

## optional

- [nvm](https://github.com/nvm-sh/nvm) (node version manager)
- [conda](https://docs.conda.io/) (python environment manager)
- [go](https://golang.org/) (go programming language)

## installation

### 1. clone the repository

```bash
git clone https://github.com/narayanananth26/zsh.git ~/.config/zsh
```

### 2. backup your existing config

```bash
# backup if .zshrc exists (might show "no such file" - that's fine, do not panic!)
mv ~/.zshrc ~/.zshrc.backup 2>/dev/null || true
```

### 3. copy the main config file

```bash
cp ~/.config/zsh/.zshrc ~/.zshrc
```

### 4. install powerlevel10k

```bash
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
```

or install to `~/.local/share/powerlevel10k/`:

```bash
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.local/share/powerlevel10k
```

**note:** the included `p10k.zsh` configuration will give you the exact prompt style used in this setup. you can customize it later by running `p10k configure`.

### 5. install recommended tools

#### macos (homebrew)

```bash
brew install fzf zoxide neovim
```

#### linux (ubuntu/debian)

```bash
sudo apt install fzf zoxide neovim
```

### 6. set up local overrides

```bash
# 1. create your local config file
cp ~/.config/zsh/zshrc.local.example ~/.zshrc.local

# 2. restart your shell so the new function is available
exec zsh

# 3. see which tools you already have installed
check-tools
```

`check-tools` will print every installed tool and its path. open `~/.zshrc.local` and uncomment the lines for tools that are missing from the output. this file is **not tracked in git** and is the right place for machine-specific paths, private api keys, and personal aliases.

### 7. configure for login shells (macos/most terminals)

```bash
# add this to ~/.zprofile to load .zshrc on startup
echo '[[ -f ~/.zshrc ]] && source ~/.zshrc' >> ~/.zprofile
```

### 8. restart your shell

```bash
exec zsh
```

on first launch, zinit will automatically install all plugins.

## customization

create a `~/.zshrc.local` file for machine-specific settings:

```bash
cp ~/.config/zsh/zshrc.local.example ~/.zshrc.local
```

this file is not tracked in git and is perfect for:

- private api keys
- machine-specific paths
- work-related configurations
- personal aliases

## alias discovery & search

### interactive fzf alias finder

press `ctrl+a` anywhere to search through all your aliases with fuzzy finding.

### search functions

```bash
# search for aliases by keyword
falias push
# shows: gp, gpf, gpsup, etc.

# list all git aliases
galias

# browse all aliases with pagination
aliases
```
