#!/usr/bin/env bash

###############################################################################
# Dropover Configuration
###############################################################################

configure_dropover() {

    log_step "Configuring Dropover"

    local app="/Applications/Dropover.app"

    if [[ ! -d "${app}" ]]; then
        log_warn "Dropover is not installed."
        return 0
    fi

    if ! pgrep -x "Dropover" >/dev/null 2>&1; then
        log_info "Launching Dropover..."
        open -a Dropover
        sleep 3
    fi

    killall cfprefsd >/dev/null 2>&1 || true

    log_success "Dropover configuration completed"

}