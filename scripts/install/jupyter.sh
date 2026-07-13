#!/usr/bin/env bash

###############################################################################
# Jupyter Configuration
###############################################################################

configure_jupyter() {

    log_step "Configuring Jupyter"

    #
    # Check uv
    #
    if ! command -v uv >/dev/null 2>&1; then
        log_warn "uv is not installed."
        return 0
    fi

    #
    # Install Jupyter
    #
    uv tool install jupyterlab

    uv tool install ipykernel

    uv tool install nbstripout

    #
    # Create Directories
    #
    mkdir -p "${HOME}/.jupyter"

    mkdir -p "${HOME}/Library/Jupyter"

    #
    # Copy Configuration
    #
    local source="${DOTFILES_DIR}/jupyter"

    if [[ -d "${source}" ]]; then

        cp -R "${source}/." "${HOME}/.jupyter"

        log_info "Installed Jupyter configuration"

    fi

    log_success "Jupyter configuration completed"

}