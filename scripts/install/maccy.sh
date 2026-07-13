#!/usr/bin/env bash

###############################################################################
# Maccy Configuration
###############################################################################

configure_maccy() {

    log_step "Configuring Maccy"

    local app="/Applications/Maccy.app"

    #
    # Check Installation
    #
    if [[ ! -d "${app}" ]]; then
        log_warn "Maccy is not installed."
        return 0
    fi

    #
    # Launch Maccy (creates preference file)
    #
    if ! pgrep -x "Maccy" >/dev/null 2>&1; then
        log_info "Launching Maccy..."
        open -a Maccy
        sleep 3
    fi

    #
    # General Settings
    #
    defaults write org.p0deje.Maccy historySize -int 2000
    defaults write org.p0deje.Maccy menuIcon -bool true
    defaults write org.p0deje.Maccy searchMode -string fuzzy
    defaults write org.p0deje.Maccy saveImages -bool true
    defaults write org.p0deje.Maccy SUAutomaticallyUpdate -bool true
    defaults write org.p0deje.Maccy menuItemCount -int 30
    defaults write org.p0deje.Maccy searchBarPosition top

    #
    # Clipboard Behavior
    #
    defaults write org.p0deje.Maccy removeFormattingByDefault -bool false
    defaults write org.p0deje.Maccy pasteByDefault -bool true
    defaults write org.p0deje.Maccy enableSound -bool false

    #
    # Appearance
    #
    defaults write org.p0deje.Maccy appearance -string system

    #
    # Launch at Login
    #
    defaults write org.p0deje.Maccy launchAtLogin -bool true

    #
    # Pin Frequently Used Items
    #
    defaults write org.p0deje.Maccy pinTo -int 20

    #
    # Excluded Applications
    #
    defaults write org.p0deje.Maccy ignoredApps -array \
        "com.apple.keychainaccess" \
        "com.1password.1password" \
        "com.agilebits.onepassword7"

    #
    # Restart Preferences
    #
    killall cfprefsd >/dev/null 2>&1 || true

    log_success "Maccy configuration completed"

}