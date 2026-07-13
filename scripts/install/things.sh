#!/usr/bin/env bash

###############################################################################
# Things Configuration
###############################################################################

configure_things() {

    log_step "Configuring Things"

    local app="/Applications/Things3.app"

    #
    # Check Installation
    #
    if [[ ! -d "${app}" ]]; then
        log_warn "Things is not installed."
        return 0
    fi

    #
    # Launch Things
    #
    if ! pgrep -x "Things3" >/dev/null 2>&1; then

        log_info "Launching Things..."

        open -a "Things3"

        sleep 5

    fi

    #
    # Create Configuration Directory
    #
    mkdir -p "${HOME}/.config/things"

    #
    # Copy User Resources
    #
    local source="${DOTFILES_DIR}/things"

    if [[ -d "${source}" ]]; then

        cp -R "${source}/." "${HOME}/.config/things"

        log_info "Installed Things resources"

    else

        log_info "No Things resources found"

    fi

    killall cfprefsd >/dev/null 2>&1 || true

    log_success "Things configuration completed"

}