#!/usr/bin/env bash

set -Eeuo pipefail

macwhisper_exists() {
    [[ -d "/Applications/MacWhisper.app" ]]
}

install_macwhisper() {

    if macwhisper_exists; then
        log_info "MacWhisper already installed."
        return
    fi

    retry 3 brew install --cask macwhisper

}

configure_macwhisper() {

    log_info "Please configure MacWhisper manually."

    log_info "Settings → Dictation"

    log_info "Settings → Live Captions"

    log_info "Settings → Meeting Detection"

    log_info "Settings → Global Shortcut"

}

setup_macwhisper() {

    install_macwhisper

    configure_macwhisper

}