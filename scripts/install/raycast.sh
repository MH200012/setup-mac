#!/usr/bin/env bash

###############################################################################
# Raycast Configuration
###############################################################################

configure_raycast() {

    log_step "Configuring Raycast"

    #
    # Raycast がインストールされているか確認
    #
    local app="/Applications/Raycast.app"

    if [[ ! -d "${app}" ]]; then
        log_warn "Raycast is not installed."
        return 0
    fi

    #
    # 起動（初回のみ設定ファイルを生成させるため）
    #
    if ! pgrep -x "Raycast" >/dev/null 2>&1; then
        log_info "Launching Raycast..."
        open -a Raycast

        # 起動待ち
        sleep 5
    fi

    #
    # Settings
    #
	local settings_source="${DOTFILES_DIR}/raycast/settings.json"
	local settings_dest="${HOME}/.config/raycast/settings.json"

	if [[ -f "${settings_source}" ]]; then

  	  mkdir -p "$(dirname "${settings_dest}")"

   	 cp "${settings_source}" "${settings_dest}"

   	 log_info "Installed Raycast settings"

	fi
   
    log_success "Raycast configuration completed"

}

install_raycast() {

    if brew list --cask raycast >/dev/null 2>&1; then
        log_info "Raycast already installed."
        return
    fi

    log_step "Installing Raycast"

    retry 3 brew install --cask raycast

    log_success "Raycast installed"

}

setup_raycast() {

    install_raycast
    configure_raycast

}