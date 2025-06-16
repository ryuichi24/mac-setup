#!/bin/bash

# utilities
source "./utils/command.sh"
source "./utils/logger.sh"

# Parse skipped config types
SKIP_TYPES=()
for arg in "$@"; do
    case "$arg" in
        -R)
            RESTART_MACOS=1
            ;;
        --skip=*)
            IFS=',' read -ra SKIP_TYPES <<<"${arg#--skip=}"
            ;;
    esac
done

# Function to check if a section should be skipped
should_skip() {
    local section="$1"
    for skip in "${SKIP_TYPES[@]}"; do
        if [[ "$skip" == "$section" ]]; then
            log_warn "Skipping $section configuration..."
            return 0
        fi
    done
    return 1
}

# =============================================
# File System
# =============================================

log_header "Setting up File System..."

if ! should_skip "fs"; then
    dev_folders=("$HOME/Dev/personal" "$HOME/Dev/work" "$HOME/Dev/personal/tmp" "$HOME/Dev/work/tmp")
    log_info "Creating development directories..."
    for folder in "${dev_folders[@]}"; do
        if [ ! -d "$folder" ]; then
            mkdir -p "$folder"
            log_success "Created directory: $folder"
        else
            log_warn "Directory already exists: $folder"
        fi
    done
    log_success "File system setup completed."
fi

# =============================================
# Load Environment Variables
# =============================================
log_header "Loading Environment Variables..."
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
# Mac Configuration
# =============================================
log_header "Setting up Mac configuration..."

if ! should_skip "mac"; then

    source "./modules/defaults.sh"

fi

# =============================================
# Git Configuration
# =============================================
log_header "Setting up Git configuration..."

if ! should_skip "git"; then

    git_config_template="./files/git/.gitconfig"
    git_config_dest="$HOME/.gitconfig"

    log_info "Setting up .gitconfig..."

    if [ -f "$git_config_template" ]; then
        log_success ".gitconfig template found at $git_config_template"
        sed "s/<git_user_name>/$GIT_USER_NAME/g; s/<git_user_email>/$GIT_USER_EMAIL/g" "$git_config_template" >"$git_config_dest"
        log_success ".gitconfig has been set up at $git_config_dest"
    else
        log_error "Git config template not found at $git_config_template"
        exit 1
    fi

fi

# =============================================
# Shell Configuration
# =============================================
log_header "Setting up Shell..."
if ! should_skip "shell"; then

    current_shell=$(echo $SHELL)
    bash_path=$(which bash)

    log_info "Checking current shell..."
    if [[ "$current_shell" != "$bash_path" ]]; then
        log_info "Changing default shell to bash..."
        chsh -s "$bash_path"
        log_success "Default shell changed to bash"

    else
        log_info "Default shell is already set to bash"
    fi

    log_info "copying dotfiles to home directory..."
    bash_dotfiles="./files/bash"
    dotfile_array=(${bash_dotfiles}/.*)

    for dotfile in "${dotfile_array[@]}"; do
        if [ -f "$dotfile" ]; then
            log_info "Found dot file: $dotfile"
            dest="$HOME/$(basename "$dotfile")"
            log_info "Copying $dotfile to $dest..."
            cp "$dotfile" "$dest"
            log_success "Copied $dotfile to $dest"
        fi
    done
fi

# =============================================
# Homebrew Setup
# =============================================
log_header "Setting up Homebrew..."
if ! should_skip "brew"; then

    # check if Xcode Command Line Tools are installed
    if ! has_command "xcode-select" "Xcode Command Line Tools"; then
        log_warn "To install 'Xcode Command Line Tools', please confirm the popup."
        xcode-select --install
    fi

    if ! has_command "brew" "Homebrew"; then
        log_warn "Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        eval "$(/opt/homebrew/bin/brew shellenv)"
        log_success "Homebrew installed successfully."
    fi

fi

# import apps
source ./modules/apps.sh

# =============================================
# Homebrew Tap Registrations
# =============================================
log_header "Registering Homebrew Tabs..."
if ! should_skip "tap"; then
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

fi
# =============================================
# CLI tool installations
# =============================================
log_header "Installing CLI tools..."
if ! should_skip "cli"; then
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
fi
# =============================================
# GUI tool installations
# =============================================
log_header "Installing GUI tools..."
if ! should_skip "gui"; then
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
fi
# =============================================
# MAS (Mac App Store) app installations
# =============================================
log_header "Installing MAS (Mac App Store) apps..."
if ! should_skip "mas"; then
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
fi
# =============================================
# VScode Setup
# ===========================================
log_header "Setting up VScode..."
if ! should_skip "vs"; then

    cp -f ./files/vscode/settings.json "$HOME/Library/Application Support/Code/User/settings.json"
    cp -f ./files/vscode/keybindings.json "$HOME/Library/Application Support/Code/User/keybindings.json"

    log_info "Installing VScode extensions..."
    cat ./files/vscode/extensions.txt | while read extension || [[ -n $extension ]]; do
        code --install-extension $extension --force
    done
    log_success "VScode extensions installed successfully."

fi
# =============================================
# Neovim Setup
# =============================================
log_header "Setting up Neovim..."
if ! should_skip "vim"; then

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

fi


# =============================================
# Rebooting macOS
# =============================================
log_header "Rebooting masOS..."

if [[ $RESTART_MACOS -eq 1 ]]; then
    sudo shutdown -r now
    log_info "Setup completed successfully! System is rebooting..."
else
    log_warn "Skipping rebooting masOS step. \n\nPass -R to restart the system in the end.\n"
fi