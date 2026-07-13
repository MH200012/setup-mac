#!/usr/bin/env bash

###############################################################################
# Notion Configuration
###############################################################################

configure_notion() {

    log_step "Configuring Notion"

    local app="/Applications/Notion.app"

    #
    # Check Installation
    #
    if [[ ! -d "${app}" ]]; then
        log_warn "Notion is not installed."
        return 0
    fi

    #
    # Launch Notion
    #
    if ! pgrep -x "Notion" >/dev/null 2>&1; then
        log_info "Launching Notion..."
        open -a Notion
        sleep 5
    fi

    #
    # Restart Preference Daemon
    #
    killall cfprefsd >/dev/null 2>&1 || true

    log_success "Notion configuration completed"

}