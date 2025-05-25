#!/bin/bash

# =============================================
# Load Environment Variables
# =============================================
if [ -f .env ]; then
    log_info "Loading environment variables from .env file..."
    set -a
    source .env
    set +a
else
    log_error ".env file not found"
    exit 1
fi

# =============================================
# Source utilities
# =============================================

# logger
source "./utils/logger.sh"
source "./utils/command.sh"

# =============================================
# MacOS Setup Entry Point
# =============================================

# Exit on error
set -e

# =============================================
# Git Configuration
# =============================================
log_info "Setting up Git configuration..."
# Read the git config template
git_config_template="./files/git/.gitconfig"
git_config_dest="$HOME/.gitconfig"

if [ -f "$git_config_template" ]; then
    # Replace placeholders with environment variables
    sed "s/<git_user_name>/$GIT_USER_NAME/g; s/<git_user_email>/$GIT_USER_EMAIL/g" "$git_config_template" > "$git_config_dest"
    log_success "Git configuration has been set up"
else
    log_error "Git config template not found at $git_config_template"
    exit 1
fi

# copy .gitmessage file
git_message_template="./files/git/.gitmessage"
git_message_dest="$HOME/.gitmessage"
if [ -f "$git_message_template" ]; then
    cp "$git_message_template" "$git_message_dest"
    log_success "Git commit message template has been copied to $git_message_dest"
else
    log_error "Git commit message template not found at $git_message_template"
    exit 1
fi

# ============================================
# Mac OS Configurations
# ============================================
source "./modules/defaults.sh"

# =============================================
# Move dot files
# =============================================

current_shell=$(dscl . -read ~/ UserShell | awk '{ print $2 }')
bash_path=$(which bash)

if [[ "$current_shell" != "$bash_path" ]]; then
    echo "Changing default shell to Bash..."
    chsh -s "$bash_path"
else
    echo "Shell is already Bash, skipping chsh."
fi

# Copy dotfiles (including hidden ones) from ./files/bash to $HOME
cp -a ./files/bash/. "$HOME/"


if ! has_command "xcode-select" "Xcode Command Line Tools"; then
    log_warn "To install 'Xcode Command Line Tools', please confirm the popup."
    xcode-select --install
fi

if ! has_command "brew" "Homebrew"; then
    log_warn "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi



# import apps
source ./modules/apps.sh

# =============================================
# Homebrew Tab Resistration
# =============================================

log_header "Homebrew Tab Resitration"
for item in "${BREW_TAPS[@]}"; do
    log_info "Registering TAP: $item"
    if brew tap | grep -qx "$item"; then
        log_warn "$item is already registered"
        continue
    fi
    
    if ! brew tap "$item"; then
        log_error "Failed to register a tap: $item"
        return 1
    fi
    
    log_success "Succssfully registered the tap: $item"
done

# =============================================
# CLI Installations (Homebrew formulae)
# =============================================
log_header "CLI Installations"
for item in "${BREW_CLIS[@]}"; do
    log_info "Installing CLI tool: $item"
    if brew list --formula | grep -qx "$item"; then
        log_warn "$item is already installed."
        continue
    fi

    if ! brew install "$item"; then
        log_error "Failed to install CLI tool: $item"
        return 1
    fi
    log_success "Successfully installed CLI tool: $item"
done

# =============================================
# GUI Installations (Homebrew casks)
# =============================================

log_header "GUI Installations"
for item in "${CASK_APPS[@]}"; do
    log_info "Installing GUI app: $item"
    if brew list --cask | grep -qx "$item"; then
        log_warn "$item is already installed."
        continue
    fi

    if ! brew install --cask "$item"; then
        log_error "Failed to install GUI app: $item"
        return 1
    fi
    log_success "Successfully installed GUI app: $item"
done

# =============================================
# MAS Installations
# =============================================

log_header "MAS Instanlations"
for mas_id in ${MAS_APPS[@]}; do
    mas_name=$(mas search $mas_id | awk '{ print $2 }')
    log_info "Installing: $mas_name ($mas_id)"

    output=$(mas install "$mas_id" 2>&1)
    status=$?

    # "-ne" means "not equal" for "numbers"
    if [[ $status -ne 0 ]]; then
        log_error "Failed to install $mas_name ($mas_id). Are you logged into the Mac App Store?"
        return 1
    fi

    echo "$output" | grep -q "already installed"
    already_installed=$?
    if [[ $already_installed -eq 0 ]]; then
        log_warn "$mas_name is already installed."
        continue
    fi
    
    log_success "Successfully installed $mas_name"
done

# =============================================
# VScode Setup
# =============================================

log_header "VScode Setup"

cp -f ./files/vscode/settings.json "$HOME/Library/Application Support/Code/User/settings.json"
cp -f ./files/vscode/keybindings.json "$HOME/Library/Application Support/Code/User/keybindings.json"

cat ./files/vscode/extensions.txt | while read extension || [[ -n $extension ]];
do
  code --install-extension $extension --force
done

# =============================================
# Neovim Setup
# =============================================
log_header "Neovim Setup"

# Create ~/.config if it doesn't exist
if [[ ! -d "$HOME/.config" ]]; then
    mkdir -p "$HOME/.config"
    log_info "Created ~/.config directory."
else
    log_info "~/.config directory already exists. Skipping creation."
fi

# Copy nvim config
cp -r ./files/nvim "$HOME/.config/"
log_success "Copied Neovim configuration to ~/.config/nvim"
