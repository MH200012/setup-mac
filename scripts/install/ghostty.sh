#!/usr/bin/env bash

###############################################################################
# Ghostty Configuration
###############################################################################

configure_ghostty() {

    log_step "Configuring Ghostty"

    local app="/Applications/Ghostty.app"

    #
    # Check Installation
    #
    if [[ ! -d "${app}" ]]; then
        log_warn "Ghostty is not installed."
        return 0
    fi

    #
    # Create Config Directory
    #
    mkdir -p "${HOME}/.config/ghostty"

    #
    # Copy Configuration
    #
    local source="${DOTFILES_DIR}/ghostty/config"

    local dest="${HOME}/.config/ghostty/config"

    if [[ -f "${source}" ]]; then

        cp "${source}" "${dest}"

        log_info "Installed Ghostty configuration"

    else

        log_info "No Ghostty configuration found"

    fi

    log_success "Ghostty configuration completed"

}