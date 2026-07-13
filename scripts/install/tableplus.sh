#!/usr/bin/env bash

###############################################################################
# TablePlus Configuration
###############################################################################

configure_tableplus() {

    log_step "Configuring TablePlus"

    local app="/Applications/TablePlus.app"

    #
    # Check Installation
    #
    if [[ ! -d "${app}" ]]; then
        log_warn "TablePlus is not installed."
        return 0
    fi

    #
    # Launch TablePlus
    #
    if ! pgrep -x "TablePlus" >/dev/null 2>&1; then

        log_info "Launching TablePlus..."

        open -a TablePlus

        sleep 5

    fi

    #
    # Create Configuration Directory
    #
    mkdir -p "${HOME}/.config/tableplus"

    #
    # Copy User Resources
    #
    local source="${DOTFILES_DIR}/tableplus"

    if [[ -d "${source}" ]]; then

        cp -R "${source}/." "${HOME}/.config/tableplus"

        log_info "Installed TablePlus resources"

    else

        log_info "No TablePlus resources found"

    fi

    killall cfprefsd >/dev/null 2>&1 || true

    log_success "TablePlus configuration completed"

}