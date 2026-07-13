#!/usr/bin/env bash

###############################################################################
# PopClip Configuration
###############################################################################

configure_popclip() {

    log_step "Configuring PopClip"

    local app="/Applications/PopClip.app"

    if [[ ! -d "${app}" ]]; then
        log_warn "PopClip is not installed."
        return 0
    fi

    if ! pgrep -x "PopClip" >/dev/null 2>&1; then
        log_info "Launching PopClip..."
        open -a PopClip
        sleep 3
    fi

    defaults write com.pilotmoon.popclip StartAtLogin -bool true
    defaults write com.pilotmoon.popclip EnableBeep -bool false

    killall cfprefsd >/dev/null 2>&1 || true

    log_success "PopClip configuration completed"

}