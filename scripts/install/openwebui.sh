#!/usr/bin/env bash

###############################################################################
# Open WebUI Configuration
###############################################################################

configure_openwebui() {

    log_step "Configuring Open WebUI"

    #
    # Check Docker
    #
    if ! command -v docker >/dev/null 2>&1; then
        log_warn "Docker is not installed."
        return 0
    fi

    #
    # Create Directory
    #
    mkdir -p "${HOME}/.config/openwebui"

    #
    # Copy Configuration
    #
    local source="${DOTFILES_DIR}/openwebui"

    if [[ -d "${source}" ]]; then

        cp -R "${source}/." "${HOME}/.config/openwebui"

        log_info "Installed Open WebUI configuration"

    else

        log_warn "No Open WebUI configuration found"
        return 0

    fi

    #
    # Start Container
    #
    (
        cd "${HOME}/.config/openwebui"

        docker compose pull

        docker compose up -d

    )

    log_success "Open WebUI configuration completed"

}