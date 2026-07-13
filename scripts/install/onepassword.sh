#!/usr/bin/env bash

###############################################################################
# 1Password Configuration
###############################################################################

configure_onepassword() {

    log_step "Configuring 1Password"

    local app="/Applications/1Password.app"

    #
    # Check Installation
    #
    if [[ ! -d "${app}" ]]; then
        log_warn "1Password is not installed."
        return 0
    fi

    #
    # Launch 1Password
    #
    if ! pgrep -x "1Password" >/dev/null 2>&1; then
        log_info "Launching 1Password..."
        open -a "1Password"
        sleep 5
    fi

    #
    # Create Configuration Directory
    #
    mkdir -p "${HOME}/.config/1Password"

    #
    # SSH Configuration
    #
    mkdir -p "${HOME}/.ssh"

    local source="${DOTFILES_DIR}/onepassword/ssh_config"
    local dest="${HOME}/.ssh/config"

    if [[ -f "${source}" ]]; then

        #
        # Backup Existing Config
        #
        if [[ -f "${dest}" ]]; then
            cp "${dest}" "${dest}.bak"
            log_info "Backed up existing SSH config"
        fi

        cp "${source}" "${dest}"

        chmod 600 "${dest}"

        log_info "Installed SSH configuration"

    else

        log_info "No SSH configuration found"

    fi

    #
    # Check 1Password CLI
    #
    if command -v op >/dev/null 2>&1; then
        log_info "1Password CLI detected"
    else
        log_warn "1Password CLI (op) is not installed."
    fi

    log_success "1Password configuration completed"

}