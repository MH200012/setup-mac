#!/usr/bin/env bash

###############################################################################
# Hugging Face Configuration
###############################################################################

configure_huggingface() {

    log_step "Configuring Hugging Face"

    #
    # Check Installation
    #
    if ! command -v huggingface-cli >/dev/null 2>&1; then
        log_warn "huggingface-cli is not installed."
        return 0
    fi

    #
    # Create Directories
    #
    mkdir -p "${HOME}/.cache/huggingface"
    mkdir -p "${HOME}/.config/huggingface"

    #
    # Copy Configuration
    #
    local source="${DOTFILES_DIR}/huggingface"

    if [[ -d "${source}" ]]; then

        cp -R "${source}/." "${HOME}/.config/huggingface"

        log_info "Installed Hugging Face configuration"

    else

        log_info "No Hugging Face configuration found"

    fi

    #
    # Login
    #
    if huggingface-cli whoami >/dev/null 2>&1; then

        log_info "Already logged in."

    else

        log_warn "Hugging Face login required."
        huggingface-cli login

    fi

    log_success "Hugging Face configuration completed"

}