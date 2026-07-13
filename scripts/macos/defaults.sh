#!/usr/bin/env bash

set -Eeuo pipefail

apply_macos_defaults() {

    log_step "Applying macOS defaults"

    #
    # General
    #

    defaults write NSGlobalDomain AppleShowAllExtensions -bool true
    defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false
    defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

    #
    # Finder
    #

    defaults write com.apple.finder AppleShowAllFiles -bool true
    defaults write NSGlobalDomain AppleShowAllExtensions -bool true
    defaults write com.apple.finder ShowPathbar -bool true
    defaults write com.apple.finder ShowStatusBar -bool true
    defaults write com.apple.finder FXPreferredViewStyle Clmv
    defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

    #
    # Dock
    #

    defaults write com.apple.dock autohide -bool true
    defaults write com.apple.dock autohide-delay -float 0
    defaults write com.apple.dock show-recents -bool false
    defaults write com.apple.dock tilesize -int 40

    #
    # Trackpad
    #

    defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
    defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true

    #
    # Keyboard
    #

    defaults write NSGlobalDomain KeyRepeat -int 2
    defaults write NSGlobalDomain InitialKeyRepeat -int 15

    #
    # Screenshots
    #

    mkdir -p "${HOME}/Pictures/Screenshots"

    defaults write com.apple.screencapture location "${HOME}/Pictures/Screenshots"
    defaults write com.apple.screencapture type png

    #
    # Safari
    #

    log_info "Configuring Safari"

    if defaults write com.apple.Safari \
        ShowFullURLInSmartSearchField -bool true 2>/dev/null
    then
        log_success "Safari configured."
    else
        log_warn "Safari settings skipped (unsupported on this macOS version)."
    fi

    #
    # Activity Monitor
    #

    defaults write com.apple.ActivityMonitor OpenMainWindow -bool true
    defaults write com.apple.ActivityMonitor IconType -int 5
    defaults write com.apple.ActivityMonitor ShowCategory -int 0

    #
    # Restart affected apps
    #

    killall Finder 2>/dev/null || true
    killall Dock 2>/dev/null || true
    killall SystemUIServer 2>/dev/null || true

    log_success "macOS defaults applied."

}