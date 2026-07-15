#!/usr/bin/env bash

set -Eeuo pipefail

###############################################################################
# Install
###############################################################################

install_dotfiles() {

    if [[ ! -d "${DOTFILES_DIR}/.git" ]]; then

        log_info "Cloning dotfiles..."

        git clone "${DOTFILES_REPO}" "${DOTFILES_DIR}"

    else

        log_info "dotfiles already exist."

    fi

}

###############################################################################
# Configure
###############################################################################

configure_dotfiles() {

    if [[ "$(chezmoi source-path)" != "${DOTFILES_DIR}" ]]; then

        log_info "Initializing chezmoi..."

        chezmoi init "${DOTFILES_DIR}"

    fi

    log_info "Applying dotfiles..."

    chezmoi apply

}

###############################################################################
# Update
###############################################################################

update_dotfiles() {

    if [[ ! -d "${DOTFILES_DIR}/.git" ]]; then
        return
    fi

    log_info "Updating dotfiles..."

    git -C "${DOTFILES_DIR}" pull --ff-only

    chezmoi apply --force

    log_success "Dotfiles updated."
}


###############################################################################
# Public
###############################################################################

setup_dotfiles() {

    install_dotfiles

    configure_dotfiles

}
