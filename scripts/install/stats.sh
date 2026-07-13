#!/usr/bin/env bash

###############################################################################
# Stats Configuration
###############################################################################

configure_stats() {

    log_step "Configuring Stats"

    local app="/Applications/Stats.app"

    if [[ ! -d "${app}" ]]; then
        log_warn "Stats is not installed."
        return 0
    fi

    if ! pgrep -x "Stats" >/dev/null 2>&1; then
        log_info "Launching Stats..."
        open -a Stats
        sleep 3
    fi

    defaults write eu.exelban.Stats runAtLogin -bool true

    killall cfprefsd >/dev/null 2>&1 || true

    log_success "Stats configuration completed"

}