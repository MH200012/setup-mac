#!/usr/bin/env bash
set -Eeuo pipefail

install_cursor() {

    if [[ -d /Applications/Cursor.app ]]; then
        log_success "Cursor is already installed."
        return
    fi

    log_step "Installing Cursor"

    brew install --cask cursor

    log_success "Cursor installed."
}