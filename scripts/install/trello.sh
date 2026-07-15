#!/usr/bin/env bash
#
# ==============================================================================
# Trello
# ==============================================================================
#
# Install Trello Desktop.
#
# Homebrew Cask has been removed, so install from the official DMG.
#
# ==============================================================================

set -Eeuo pipefail

################################################################################
# Constants
################################################################################

readonly TRELLO_APP="/Applications/Trello.app"
readonly TRELLO_DMG="/tmp/Trello.dmg"
readonly TRELLO_MOUNT="/Volumes/Trello"

# 最新版DMG
readonly TRELLO_URL="https://desktop.trello.com/mac/download"

################################################################################
# Check
################################################################################

trello_exists() {

    [[ -d "${TRELLO_APP}" ]]

}

################################################################################
# Install
################################################################################

install_trello() {

    if trello_exists; then
        log_info "Trello already installed."
        return
    fi

    log_info "Downloading Trello..."

    curl -fsSL \
        -o "${TRELLO_DMG}" \
        "${TRELLO_URL}"

    log_info "Mounting DMG..."

    hdiutil attach "${TRELLO_DMG}" \
        -nobrowse \
        -quiet

    log_info "Installing Trello..."

    cp -R \
        "${TRELLO_MOUNT}/Trello.app" \
        /Applications/

    log_info "Unmounting DMG..."

    hdiutil detach \
        "${TRELLO_MOUNT}" \
        -quiet

    rm -f "${TRELLO_DMG}"

    log_success "Trello installed."

}

################################################################################
# Verify
################################################################################

verify_trello() {

    if trello_exists; then
        log_success "Trello verified."
    else
        log_error "Trello installation failed."
        return 1
    fi

}

################################################################################
# Public
################################################################################

setup_trello() {

    install_trello

    verify_trello

}