#!/usr/bin/env bash

###############################################################################
# Shottr Configuration
###############################################################################

configure_shottr() {

    log_step "Configuring Shottr"

    local app="/Applications/Shottr.app"

    if [[ ! -d "${app}" ]]; then
        log_warn "Shottr is not installed."
        return 0
    fi

    if ! pgrep -x "Shottr" >/dev/null 2>&1; then
        log_info "Launching Shottr..."
        open -a Shottr
        sleep 3
    fi

    killall cfprefsd >/dev/null 2>&1 || true

    log_success "Shottr configuration completed"

}