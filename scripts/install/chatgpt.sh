#!/usr/bin/env bash

###############################################################################
# ChatGPT Desktop Configuration
###############################################################################

configure_chatgpt() {

    log_step "Configuring ChatGPT Desktop"

    local app="/Applications/ChatGPT.app"

    #
    # Check Installation
    #
    if [[ ! -d "${app}" ]]; then
        log_warn "ChatGPT Desktop is not installed."
        return 0
    fi

    #
    # Launch ChatGPT
    #
    if ! pgrep -x "ChatGPT" >/dev/null 2>&1; then
        log_info "Launching ChatGPT..."
        open -a ChatGPT
        sleep 5
    fi

    #
    # Create configuration directory
    #
    mkdir -p "${HOME}/.config/chatgpt"

    #
    # Copy user configuration (optional)
    #
    local source="${DOTFILES_DIR}/chatgpt"

    if [[ -d "${source}" ]]; then

        cp -R "${source}/." "${HOME}/.config/chatgpt"

        log_info "Installed ChatGPT configuration"

    else

        log_info "No ChatGPT configuration found"

    fi

    killall cfprefsd >/dev/null 2>&1 || true

    log_success "ChatGPT Desktop configuration completed"

}