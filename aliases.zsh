# Aliases

# General
alias xx="clear"
alias vi="nvim"
alias vim="nvim"

# Tmux
alias ta="tmux attach"
alias td="tmux detach"

# Fuzzy find
alias ff="fzf"

# Alias helpers (search/browse aliases)
alias aliases="alias | less"  # Browse all aliases with pagination

# ====================================
# Git Aliases (Custom - replacing OMZ)
# ====================================

# Basic shortcuts
alias g="git"
alias gst="git status"
alias gs="git status"
alias gss="git status -s"

# Add
alias ga="git add"
alias gaa="git add --all"
alias gap="git add --patch"

# Branch
alias gb="git branch"
alias gba="git branch -a"
alias gbd="git branch -d"
alias gbD="git branch -D"

# Commit
alias gc="git commit -v"
alias gcm="git commit -m"
alias gca="git commit -v -a"
alias gcam="git commit -a -m"
alias gcmsg="git commit -m"
alias gcan="git commit -v -a --no-edit --amend"
alias gcn="git commit -v --no-edit --amend"

# Checkout
alias gco="git checkout"
alias gcb="git checkout -b"
alias gcom="git checkout main || git checkout master"  # Changed from gcm to avoid conflict
alias gcd="git checkout develop"

# Switch
alias gsw="git switch"
alias gswc="git switch -c"

# Clone
alias gcl="git clone"

# Diff
alias gd="git diff"
alias gds="git diff --staged"
alias gdca="git diff --cached"

# Fetch
alias gf="git fetch"
alias gfa="git fetch --all"
alias gfo="git fetch origin"

# Pull
alias gl="git pull"
alias gup="git pull --rebase"
alias glr="git pull --rebase"
alias gpr="git pull --rebase"

# Push
alias gp="git push"
alias gpf="git push --force-with-lease"
alias gpff="git push --force"
alias gpoat="git push origin --all && git push origin --tags"

# Push with upstream
gpsup() {
    git push --set-upstream origin $(git symbolic-ref --short HEAD)
}

# Rebase
alias grb="git rebase"
alias grbi="git rebase -i"
alias grbc="git rebase --continue"
alias grba="git rebase --abort"

# Remote
alias gr="git remote"
alias grv="git remote -v"
alias gra="git remote add"

# Reset
alias grh="git reset"
alias grhh="git reset --hard"
# groh - Reset to origin/current-branch (function to avoid startup git calls)

# Stash
alias gsta="git stash"
alias gstaa="git stash apply"
alias gstc="git stash clear"
alias gstd="git stash drop"
alias gstl="git stash list"
alias gstp="git stash pop"
alias gsts="git stash show --text"

# Log
alias glog="git log --oneline --decorate --graph"
alias gloga="git log --oneline --decorate --graph --all"
alias glg="git log --stat"
alias glgg="git log --graph"
alias glgga="git log --graph --decorate --all"
alias glol="git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset'"
alias glola="git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset' --all"

# Merge
alias gm="git merge"
alias gma="git merge --abort"

# Show
alias gsh="git show"

# Tag
alias gt="git tag"

# Worktree
alias gwt="git worktree"
alias gwta="git worktree add"
alias gwtl="git worktree list"
alias gwtr="git worktree remove"

# Get current branch
git_current_branch() {
    git symbolic-ref --short HEAD 2> /dev/null
}

# Reset to origin/current-branch
groh() {
    local branch=$(git_current_branch)
    if [[ -n "$branch" ]]; then
        git reset "origin/$branch" --hard
    else
        echo "Not in a git repository or no branch found"
        return 1
    fi
}

