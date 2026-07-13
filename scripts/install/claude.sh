#!/usr/bin/env bash

###############################################################################
# Claude Desktop Configuration
###############################################################################

configure_claude() {

    log_step "Configuring Claude Desktop"

    local app="/Applications/Claude.app"

    #
    # Check Installation
    #
    if [[ ! -d "${app}" ]]; then
        log_warn "Claude Desktop is not installed."
        return 0
    fi

    #
    # Launch Claude
    #
    if ! pgrep -x "Claude" >/dev/null 2>&1; then
        log_info "Launching Claude..."
        open -a Claude
        sleep 5
    fi

    #
    # Create Config Directory
    #
    mkdir -p "${HOME}/.config/claude"

    #
    # Copy configuration
    #
    local source="${DOTFILES_DIR}/claude"

    if [[ -d "${source}" ]]; then

        cp -R "${source}/." "${HOME}/.config/claude"

        log_info "Installed Claude configuration"

    else

        log_info "No Claude configuration found"

    fi

    killall cfprefsd >/dev/null 2>&1 || true

    log_success "Claude Desktop configuration completed"

}