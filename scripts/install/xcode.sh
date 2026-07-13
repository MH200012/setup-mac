#!/usr/bin/env bash
#
# ==============================================================================
# Xcode Command Line Tools
# ==============================================================================
#
# Install Xcode Command Line Tools if they are not already installed.
#
# ==============================================================================

set -Eeuo pipefail

################################################################################
# Check
################################################################################

xcode_installed() {

    xcode-select -p >/dev/null 2>&1

}

################################################################################
# Install
################################################################################

install_xcode() {

    if xcode_installed; then
        log_info "Xcode Command Line Tools already installed."
        return
    fi

    log_info "Installing Xcode Command Line Tools..."

    xcode-select --install || true

    log_warn "Waiting for installation to complete..."

    until xcode_installed; do
        sleep 10
    done

    log_success "Xcode Command Line Tools installed."

}

################################################################################
# License
################################################################################

accept_xcode_license() {

    if ! xcode_installed; then
        return
    fi

    log_info "Accepting Xcode license..."

    sudo xcodebuild -license accept >/dev/null 2>&1 || true

}

################################################################################
# First Launch
################################################################################

run_xcode_first_launch() {

    if ! xcode_installed; then
        return
    fi

    log_info "Running Xcode first launch..."

    sudo xcodebuild -runFirstLaunch >/dev/null 2>&1 || true

}

################################################################################
# Configure
################################################################################

configure_xcode() {

    accept_xcode_license

    run_xcode_first_launch

}

################################################################################
# Public
################################################################################

setup_xcode() {

    install_xcode

    configure_xcode

}