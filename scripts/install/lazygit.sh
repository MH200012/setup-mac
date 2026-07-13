#!/usr/bin/env bash

###############################################################################
# Lazygit Configuration
###############################################################################

configure_lazygit() {

    log_step "Configuring Lazygit"

    #
    # Check Installation
    #
    if ! command -v lazygit >/dev/null 2>&1; then
        log_warn "Lazygit is not installed."
        return 0
    fi

    #
    # Create Config Directory
    #
    mkdir -p "${HOME}/.config/lazygit"

    #
    # Copy Configuration
    #
    local source="${DOTFILES_DIR}/lazygit/config.yml"

    local dest="${HOME}/.config/lazygit/config.yml"

    if [[ -f "${source}" ]]; then

        cp "${source}" "${dest}"

        log_info "Installed Lazygit configuration"

    else

        log_info "No Lazygit configuration found"

    fi

    log_success "Lazygit configuration completed"

}