#!/usr/bin/env bash
#
# ==============================================================================
# Git
# ==============================================================================
#
# Install and verify Git.
#
# Git configuration (.gitconfig) is managed by chezmoi.
#
# ==============================================================================

set -Eeuo pipefail

################################################################################
# Check
################################################################################

git_exists() {

    command_exists git

}

################################################################################
# Install
################################################################################

install_git() {

    if git_exists; then
        log_info "Git already installed."
        return
    fi

    log_info "Installing Git..."

    retry 3 brew install git

    log_success "Git installed."

}

################################################################################
# Configure
################################################################################

configure_git() {

    if [[ ! -f "${HOME}/.gitconfig" ]]; then
        log_warn ".gitconfig not found."
        log_warn "Git configuration will be applied later by chezmoi."
        return
    fi

    log_info ".gitconfig found."

}

################################################################################
# Verify
################################################################################

verify_git() {

    require_command git

    local version
    version="$(git --version)"

    log_info "${version}"

}

################################################################################
# Public
################################################################################

setup_git() {

    install_git

    configure_git

    verify_git

}