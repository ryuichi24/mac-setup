#!/bin/bash

# =============================================
# Homebrew Tap Sources
# =============================================
BREW_TAPS=(
    # "lyraphase/pcloud" # pCloud Drive support
    # https://github.com/Homebrew/homebrew-cask-fonts?utm_source=chatgpt.com
    # "homebrew/cask-fonts"
)

# =============================================
# Command Line Tools
# =============================================
BREW_CLIS=(
    "mas"     # Mac App Store command line interface
    # "nvm"     # Node Version Manager
    # "rbenv"   # Ruby Environment
    # "pnpm"    # Fast, disk space efficient package manager
    # "go"      # Go programming language
    # "gcc"     # GNU Compiler Collection
    # "cmake"   # Build system
    # "ffmpeg"  # Multimedia framework
    "neovim"  # Text editor
    "lua"      # Lua programming language
    "lua-language-server"   # Language server for Lua
    "kanata"    # keymap remapper
    # "ollama"  # AI models tool
    # "yt-dlp"  # Media downloader
    # "tree"    # Directory listing command
    # "ripgrep" # Fast text search tool
    # "lazygit"
    # "gh" # GitHub CLI

    # "diff-so-fancy" # Improved diff output
    # "imagemagick"   # Image manipulation tools
    # "katana"        # Web application security tool
    # "xtool-org/tap/xtool"  # XTool utilities
    "koekeishiya/formulae/skhd"   # Hotkey daemon for macOS must to start by `skhd --start-service`
    # dev dependencies
    # "zeromq" # ZeroMQ messaging library
)

# =============================================
# GUI Applications (Casks)
# =============================================
CASK_APPS=(
    "iterm2"              # Terminal emulator
    # "claude"               # AI assistant
    # "windsurf"             # Network utility
    # "cursor"               # Code editor
    "visual-studio-code" # Code editor
    "brave-browser"      # Web browser
    # "google-chrome"      # Web browser
    # "firefox"            # Web browser
    # "discord"            # Communication platform
    # "whatsapp"           # Messaging app
    "bitwarden"          # Password manager
    "readdle-spark"      # Email client
    # "bruno"              # API client
    # "orbstack"           # Container platform
    "karabiner-elements" # Keyboard customizer
    # "microsoft-teams"    # Communication platform
    # "betterdisplay"      # Display management
    # "handbrake"          # Video transcoder
    # "kap"                # Screen recorder
    # "monitorcontrol"     # External display controller
    # "rectangle"          # Window manager
    "raycast"            # Productivity tool
    # "alt-tab"            # Window switcher
    # "cryptomator"        # Encryption tool
    # "iterm2"             # Terminal emulator
    # "obs"                # Streaming software
    # "blackhole-2ch"      # Audio driver
    # "blackhole-16ch"     # Audio driver
    # "figma"              # Design tool
    # "obsidian"             # Note-taking app
    # "pcloud-drive"         # Cloud storage
    # "utm"                  # Virtual machines
    # "vmware-fusion"        # Virtualization
    # "rustdesk"             # Remote desktop
    # "keka"                 # File archiver
    # "maccy"                # Clipboard manager
    # "font-symbols-only-nerd-font"  # Nerd fonts
    # "qt-creator"           # Qt IDE
    # font-meslo-lg-nerd-font # font
    # "betterdisplay"      # Display management
)

# =============================================
# Mac App Store Applications
# =============================================
MAS_APPS=(
    # 539883307  # LINE
    # 1507246666 # Presentify
    # 1517772049 # Urban VPN Desktop
    # 497799835  # Xcode
    # 411213048  # LadioCast
)
