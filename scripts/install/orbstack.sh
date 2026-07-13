#!/usr/bin/env bash

###############################################################################
# OrbStack Configuration
###############################################################################

configure_orbstack() {

    log_step "Configuring OrbStack"

    local app="/Applications/OrbStack.app"

    #
    # Check Installation
    #
    if [[ ! -d "${app}" ]]; then
        log_warn "OrbStack is not installed."
        return 0
    fi

    #
    # Launch OrbStack
    #
    if ! pgrep -x "OrbStack" >/dev/null 2>&1; then

        log_info "Launching OrbStack..."

        open -a OrbStack

        #
        # Wait until Docker becomes available
        #
        local retries=30

        while ! docker info >/dev/null 2>&1; do

            sleep 2

            retries=$((retries - 1))

            if [[ ${retries} -le 0 ]]; then
                log_warn "Docker daemon did not become ready."
                return 0
            fi

        done

    fi

    #
    # Verify Docker
    #
    if docker info >/dev/null 2>&1; then
        log_info "Docker is available."
    else
        log_warn "Docker is not available."
        return 0
    fi

    #
    # Verify Docker Compose
    #
    if docker compose version >/dev/null 2>&1; then
        log_info "Docker Compose is available."
    else
        log_warn "Docker Compose is not available."
    fi

    #
    # Create Workspace
    #
    mkdir -p "${HOME}/Containers"

    log_success "OrbStack configuration completed"

}