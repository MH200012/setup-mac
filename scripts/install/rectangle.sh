#!/usr/bin/env bash

###############################################################################
# Rectangle Configuration
###############################################################################

configure_rectangle() {

    log_step "Configuring Rectangle"

    local app="/Applications/Rectangle.app"

    #
    # Check Installation
    #
    if [[ ! -d "${app}" ]]; then
        log_warn "Rectangle is not installed."
        return 0
    fi

    #
    # Launch Rectangle (creates preference file)
    #
    if ! pgrep -x "Rectangle" >/dev/null 2>&1; then
        log_info "Launching Rectangle..."
        open -a Rectangle
        sleep 3
    fi

    #
    # General Settings
    #
    defaults write com.knollsoft.Rectangle launchOnLogin -bool true
    defaults write com.knollsoft.Rectangle hideMenubarIcon -bool false
    defaults write com.knollsoft.Rectangle SUEnableAutomaticChecks -bool true

    #
    # Window Management
    #
    defaults write com.knollsoft.Rectangle allowAnyShortcut -bool true
    defaults write com.knollsoft.Rectangle snapAreasOnHover -bool true
    defaults write com.knollsoft.Rectangle subsequentExecutionMode -int 1

    #
    # Restore Previous Window Size
    #
    defaults write com.knollsoft.Rectangle restoreWindowSize -bool true

    #
    # Gap Between Windows
    #
    defaults write com.knollsoft.Rectangle gapSize -int 6

    #
    # Disable Window Throw
    #
    defaults write com.knollsoft.Rectangle enableWindowThrow -bool false

    #
    # Apply Preferences
    #
    killall cfprefsd >/dev/null 2>&1 || true

    log_success "Rectangle configuration completed"

}