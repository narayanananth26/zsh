```bash
git clone https://github.com/narayanananth26/zsh.git ~/.config/zsh
```

```bash
# backup if .zshrc exists
mv ~/.zshrc ~/.zshrc.backup 2>/dev/null || true
```

```bash
cp ~/.config/zsh/.zshrc ~/.zshrc
```

```bash
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
```

or install to `~/.local/share/powerlevel10k/`:

```bash
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.local/share/powerlevel10k
```


### Tools


```bash
brew install fzf zoxide neovim
```
or

```bash
sudo apt install fzf zoxide neovim
```

### Local overrides

```bash
cp ~/.config/zsh/zshrc.local.example ~/.zshrc.local
```
