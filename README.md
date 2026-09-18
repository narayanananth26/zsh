### Prerequisites

A [Nerd Font](https://www.nerdfonts.com/) installed and selected in your
terminal, otherwise the Powerlevel10k prompt renders as boxes.

### Install

```bash
git clone https://github.com/narayanananth26/zsh.git ~/.config/zsh
```

```bash
# backup if .zshrc exists
[ -f ~/.zshrc ] && mv ~/.zshrc ~/.zshrc.backup
```

```bash
# create symlink
ln -sfn ~/.config/zsh/.zshrc ~/.zshrc
```

### Powerlevel10k

```bash
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
```

or install to `~/.local/share/powerlevel10k/`:

```bash
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.local/share/powerlevel10k
```

### Tools

```bash
brew install fzf zoxide neovim gh
```

or

```bash
sudo apt install fzf zoxide neovim gh
```

### Environment

Pure exports live in `~/.zshenv` so scripts and GUI-launched processes see them
too. That file is not tracked here so create it per machine requirements:

```bash
cat > ~/.zshenv <<'ZSHENV'
export PATH="$HOME/.local/bin:$PATH"
export NVM_DIR="$HOME/.nvm"
export PNPM_HOME="$HOME/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"
ZSHENV
```

`environment.zsh` lazy-loads `nvm` and `conda` and appends Go's `GOPATH/bin`, so
it depends on these being set.

### Local overrides

```bash
cp ~/.config/zsh/zshrc.local.example ~/.zshrc.local
```

Machine-specific PATH entries, API keys and private aliases belong here.
