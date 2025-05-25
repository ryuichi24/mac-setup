# https://discussions.apple.com/thread/255287296?utm_source=chatgpt.com&sortBy=rank
# https://www.theverge.com/2019/6/4/18651872/apple-macos-catalina-zsh-bash-shell-replacement-features
# https://discussions.apple.com/thread/250729585?sortBy=rank 
export BASH_SILENCE_DEPRECATION_WARNING=1

# homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# nvm
export NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh

# ~/.bash_profile: executed by bash(1) for non-login shells.
if [ -r ~/.bashrc ]; then
    . ~/.bashrc
fi
