#!/bin/bash

# =============================================
# MacOS System Defaults Configuration Script
# @see https://macos-defaults.com/ for more "defaults" commands
# =============================================

# Exit on error
set -e

echo "🔧 Starting MacOS system configuration..."

# =============================================
# Menu Bar Settings
# =============================================
echo "⚙️ Configuring Menu Bar settings..."

# Set clock format to 24-hour
defaults write com.apple.menuextra.clock Show24Hour -bool true

# =============================================
# Finder Preferences
# =============================================
echo "📂 Configuring Finder preferences..."

# File visibility settings
defaults write NSGlobalDomain AppleShowAllExtensions -bool true   # Show all file extensions
defaults write com.apple.finder AppleShowAllFiles -bool true      # Show hidden files
defaults write com.apple.finder CreateDesktop -bool false         # Hide desktop icons

# User experience improvements
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false  # No extension change warning
defaults write com.apple.finder ShowPathbar -bool true           # Show path bar
defaults write com.apple.finder ShowStatusBar -bool true         # Show status bar

# Apply Finder changes
echo "🔄 Applying Finder changes..."
killall Finder

# =============================================
# Dock Configuration
# =============================================
echo "🚀 Configuring Dock settings..."

# Visibility and position
defaults write com.apple.dock autohide -bool true          # Auto-hide Dock
defaults write com.apple.dock show-recents -bool false     # Hide recent apps
defaults write com.apple.dock orientation -string "left"    # Position on left

# Size and appearance
defaults write com.apple.dock tilesize -int 25             # Icon size: 25px
defaults write com.apple.dock magnification -bool true     # Enable magnification
defaults write com.apple.dock largesize -int 32            # Magnified size: 32px
defaults write com.apple.dock mineffect -string "scale"    # Scale minimize effect

# Animation settings
defaults write com.apple.dock launchanim -bool false       # Disable launch animation

# Apply Dock changes
echo "🔄 Applying Dock changes..."
killall Dock

# =============================================
# Global System Preferences
# =============================================
echo "🌐 Configuring global system preferences..."

# Appearance and Interface
defaults write NSGlobalDomain AppleInterfaceStyle -string "Dark"  # Enable Dark Mode
defaults write NSGlobalDomain _HIHideMenuBar -bool false          # Always show menu bar

# Keyboard settings
defaults write NSGlobalDomain KeyRepeat -int 2                    # Fast key repeat rate

# key repeat
defaults write -g ApplePressAndHoldEnabled -bool false

# Mouse and Trackpad settings
defaults write -g com.apple.trackpad.scaling -float 1 # Trackpad scaling
defaults write -g com.apple.mouse.scaling -float 1 # Mouse scaling

# Enable tap to click on trackpad
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
# Enable tap to click on trackpad for all users
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true

# disable user interface sound
defaults write com.apple.systemsound "com.apple.sound.uiaudio.enabled" -bool false

# Disable Cmd + Space Spotlight shortcut
/usr/libexec/PlistBuddy -c "Set :AppleSymbolicHotKeys:64:enabled false" ~/Library/Preferences/com.apple.symbolichotkeys.plist
# Disable Ctrl + Space input source switch shortcut
# /usr/libexec/PlistBuddy -c "Set :AppleSymbolicHotKeys:65:enabled false" ~/Library/Preferences/com.apple.symbolichotkeys.plist


# killall SystemUIServer
# =============================================
# Security & Authentication
# =============================================
echo "🔒 Configuring security settings..."

# Enable Touch ID for sudo
echo "👆 Configuring Touch ID for sudo authentication..."
TARGET_FILE="/etc/pam.d/sudo"
LINE="auth sufficient pam_tid.so"
BACKUP_FILE="${TARGET_FILE}.bak"

# Make a backup
sudo cp "$TARGET_FILE" "$BACKUP_FILE"

# Check if the line already exists
if ! grep -Fxq "$LINE" "$TARGET_FILE"; then
  log_info "Setting up Touch ID for sudo..."
  sudo sh -c "echo '$LINE' | cat - $TARGET_FILE > ${TARGET_FILE}.new && mv ${TARGET_FILE}.new $TARGET_FILE"
  log_success "Touch ID sudo configuration complete."
else
  log_warn "Touch ID sudo is already configured."
fi

# Delete the backup
sudo rm "$BACKUP_FILE"

# =============================================
# Final Steps
# =============================================
echo "✨ Applying all changes..."
/System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u

echo "✅ MacOS system configuration complete!"
echo "Note: Some changes may require a logout/login or restart to take effect."
