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

# =============================================
# Security & Authentication
# =============================================
echo "🔒 Configuring security settings..."

# Enable Touch ID for sudo
echo "👆 Configuring Touch ID for sudo authentication..."
sudo sed -i '' '/pam_tid.so/d' /etc/pam.d/sudo && echo 'auth sufficient pam_tid.so' | sudo tee -a /etc/pam.d/sudo

# =============================================
# Final Steps
# =============================================
echo "✨ Applying all changes..."
/System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u

echo "✅ MacOS system configuration complete!"
echo "Note: Some changes may require a logout/login or restart to take effect."
