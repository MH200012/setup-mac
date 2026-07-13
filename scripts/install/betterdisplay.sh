#!/usr/bin/env bash

###############################################################################
# BetterDisplay Configuration
###############################################################################

configure_betterdisplay() {

    log_step "Configuring BetterDisplay"

    local app="/Applications/BetterDisplay.app"

    if [[ ! -d "${app}" ]]; then
        log_warn "BetterDisplay is not installed."
        return 0
    fi

    if ! pgrep -x "BetterDisplay" >/dev/null 2>&1; then
        log_info "Launching BetterDisplay..."
        open -a BetterDisplay
        sleep 3
    fi

    killall cfprefsd >/dev/null 2>&1 || true

    log_success "BetterDisplay configuration completed"

}