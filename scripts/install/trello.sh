#!/usr/bin/env bash
#
# ==============================================================================
# Trello
# ==============================================================================
#
# Install Trello Desktop from the Mac App Store.
#
# ==============================================================================

set -Eeuo pipefail

################################################################################
# Constants
################################################################################

readonly TRELLO_APP="/Applications/Trello.app"
readonly TRELLO_APP_STORE_ID="1278508951"

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

    require_command mas

    log_info "Installing Trello from the Mac App Store..."

    mas install "${TRELLO_APP_STORE_ID}"

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
