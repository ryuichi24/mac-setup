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

# go
export PATH="$PATH:$(go env GOPATH)/bin"

# flutter
export PATH=$HOME/.flutter/bin:$PATH

# cocoapods
export PATH=$HOME/.gem/bin:$PATH

# ruby
# https://chatgpt.com/c/683733ba-ff54-800f-b590-bca3ce68d9dc
export LDFLAGS="-L/opt/homebrew/opt/openssl@3/lib -L/opt/homebrew/opt/readline/lib -L/opt/homebrew/opt/libyaml/lib -L/opt/homebrew/opt/gmp/lib"
export CPPFLAGS="-I/opt/homebrew/opt/openssl@3/include -I/opt/homebrew/opt/readline/include -I/opt/homebrew/opt/libyaml/include -I/opt/homebrew/opt/gmp/include"
export PKG_CONFIG_PATH="/opt/homebrew/opt/openssl@3/lib/pkgconfig:/opt/homebrew/opt/readline/lib/pkgconfig:/opt/homebrew/opt/libyaml/lib/pkgconfig:/opt/homebrew/opt/gmp/lib/pkgconfig"

# rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"