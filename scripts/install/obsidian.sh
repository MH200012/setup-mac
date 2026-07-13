#!/usr/bin/env bash

###############################################################################
# Obsidian Configuration
###############################################################################

configure_obsidian() {

    log_step "Configuring Obsidian"

    local app="/Applications/Obsidian.app"

    #
    # Check Installation
    #
    if [[ ! -d "${app}" ]]; then
        log_warn "Obsidian is not installed."
        return 0
    fi

    #
    # Launch Obsidian
    #
    if ! pgrep -x "Obsidian" >/dev/null 2>&1; then
        log_info "Launching Obsidian..."
        open -a Obsidian
        sleep 5
    fi

    #
    # Create Vault
    #
    local vault="${HOME}/Documents/Obsidian"

    if [[ ! -d "${vault}" ]]; then
        mkdir -p "${vault}"
        log_info "Created Vault: ${vault}"
    fi

    #
    # Create .obsidian
    #
    mkdir -p "${vault}/.obsidian"

    #
    # Copy Settings
    #
    local source="${DOTFILES_DIR}/obsidian/.obsidian"

    if [[ -d "${source}" ]]; then

        cp -R "${source}/." "${vault}/.obsidian"

        log_info "Installed Obsidian settings"

    fi

    #
    # Create folders
    #
    mkdir -p "${vault}/Inbox"
    mkdir -p "${vault}/Daily"
    mkdir -p "${vault}/Projects"
    mkdir -p "${vault}/AI"
    mkdir -p "${vault}/Knowledge"
    mkdir -p "${vault}/Templates"
    mkdir -p "${vault}/Attachments"

    #
    # Community Plugins
    #
    mkdir -p "${vault}/.obsidian/plugins"

    killall cfprefsd >/dev/null 2>&1 || true

    log_success "Obsidian configuration completed"

}