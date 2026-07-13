#!/usr/bin/env bash
#
# ==============================================================================
# GitHub CLI
# ==============================================================================
#
# Install and configure GitHub CLI.
#
# ==============================================================================

set -Eeuo pipefail

################################################################################
# Check
################################################################################

github_cli_exists() {

    command_exists gh

}

################################################################################
# Install
################################################################################

install_github_cli() {

    if github_cli_exists; then
        log_info "GitHub CLI already installed."
        return
    fi

    log_info "Installing GitHub CLI..."

    retry 3 brew install gh

    log_success "GitHub CLI installed."

}

################################################################################
# Authentication
################################################################################

github_authenticated() {

    gh auth status >/dev/null 2>&1

}

authenticate_github() {

    if github_authenticated; then

        log_info "GitHub already authenticated."

        return

    fi

    log_warn "GitHub authentication required."

    gh auth login

}

################################################################################
# Verify
################################################################################

verify_github_cli() {

    require_command gh

    log_info "$(gh --version | head -n1)"

}

################################################################################
# Public
################################################################################

setup_github_cli() {

    install_github_cli

    authenticate_github

    verify_github_cli

}