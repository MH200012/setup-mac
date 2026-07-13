#!/usr/bin/env bash

###############################################################################
# Trello Configuration
###############################################################################

configure_trello() {

    log_step "Configuring Trello"

    local app="/Applications/Trello.app"

    #
    # Check Installation
    #
    if [[ ! -d "${app}" ]]; then
        log_warn "Trello is not installed."
        return 0
    fi

    #
    # Launch Trello
    #
    if ! pgrep -x "Trello" >/dev/null 2>&1; then

        log_info "Launching Trello..."

        open -a Trello

        sleep 5

    fi

    #
    # Create Configuration Directory
    #
    mkdir -p "${HOME}/.config/trello"

    #
    # Copy User Resources
    #
    local source="${DOTFILES_DIR}/trello"

    if [[ -d "${source}" ]]; then

        cp -R "${source}/." "${HOME}/.config/trello"

        log_info "Installed Trello resources"

    else

        log_info "No Trello resources found"

    fi

    killall cfprefsd >/dev/null 2>&1 || true

    log_success "Trello configuration completed"

}