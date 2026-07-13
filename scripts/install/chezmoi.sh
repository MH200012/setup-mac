#!/usr/bin/env bash
#
# ==============================================================================
# chezmoi
# ==============================================================================
#
# Install and configure chezmoi.
#
# ==============================================================================

set -Eeuo pipefail

################################################################################
# Check
################################################################################

chezmoi_exists() {

    command_exists chezmoi

}

################################################################################
# Install
################################################################################

install_chezmoi() {

    if chezmoi_exists; then

        log_info "chezmoi already installed."

        return

    fi

    log_info "Installing chezmoi..."

    retry 3 brew install chezmoi

    log_success "chezmoi installed."

}

################################################################################
# Initialize
################################################################################

initialize_chezmoi() {

    if [[ ! -d "${HOME}/.local/share/chezmoi" ]]; then

        log_info "Initializing chezmoi..."

        local github_user
        local chezmoi_repo
        
        github_user="$(get_config github_user)"
        chezmoi_repo="$(get_config chezmoi_repo)"

        chezmoi init \
    "https://github.com/${github_user}/${chezmoi_repo}.git"

    fi

}

################################################################################
# Apply
################################################################################

apply_dotfiles() {

    log_info "Applying dotfiles..."

    chezmoi apply

    log_success "Dotfiles applied."

}

################################################################################
# Update
################################################################################

update_chezmoi() {

    log_info "Updating chezmoi repository..."

    chezmoi update

    log_success "chezmoi updated."

}

################################################################################
# Verify
################################################################################

verify_chezmoi() {

    require_command chezmoi

    log_info "$(chezmoi --version)"

}

################################################################################
# Public
################################################################################

setup_chezmoi() {

    install_chezmoi

    initialize_chezmoi

    apply_dotfiles

    verify_chezmoi

}