# bash
alias ls='ls -larth --color=auto'
# alias
alias pn='pnpm'
alias vi='nvim'
alias vim="nvim"
# git alias
alias gs='git status --short'
alias gb='git branch'
# %h => commit hash
# %an => author name
# %ar => commit time
# %D => ref names (branch, tag, etc.)
# %n => new line
# %s => commit message
# %C => color
alias gl='git log --all --graph --pretty=format:"%C(magenta)%h %C(white)%an %ar %C(auto)%D%n%s%n"'
alias gd='git diff --output-indicator-new=" " --output-indicator-old=" "'
alias ga='git add'
alias gap='git add --patch'
alias gc='git commit -m'
alias gp='git push'
alias gu='git pull'
alias gch='git checkout'