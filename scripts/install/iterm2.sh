#!/usr/bin/env bash

###############################################################################
# iTerm2 Configuration
###############################################################################

configure_iterm2() {

    log_step "Configuring iTerm2"

    local app="/Applications/iTerm.app"

    #
    # Check Installation
    #
    if [[ ! -d "${app}" ]]; then
        log_warn "iTerm2 is not installed."
        return 0
    fi

    #
    # Launch iTerm2
    #
    if ! pgrep -x "iTerm2" >/dev/null 2>&1; then

        log_info "Launching iTerm2..."

        open -a iTerm

        sleep 5

    fi

    #
    # Create Preferences Directory
    #
    mkdir -p "${HOME}/Library/Preferences"

    #
    # Copy Preferences
    #
    local source="${DOTFILES_DIR}/iterm2/com.googlecode.iterm2.plist"

    local dest="${HOME}/Library/Preferences/com.googlecode.iterm2.plist"

    if [[ -f "${source}" ]]; then

        cp "${source}" "${dest}"

        log_info "Installed iTerm2 preferences"

    else

        log_info "No iTerm2 preferences found"

    fi

    #
    # Reload Preferences
    #
    killall cfprefsd >/dev/null 2>&1 || true

    log_success "iTerm2 configuration completed"

}