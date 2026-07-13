#!/usr/bin/env bash

###############################################################################
# Ollama Configuration
###############################################################################

configure_ollama() {

    log_step "Configuring Ollama"

    #
    # Check Installation
    #
    if ! command -v ollama >/dev/null 2>&1; then
        log_warn "Ollama is not installed."
        return 0
    fi

    #
    # Start Ollama Service
    #
    if ! pgrep -x "ollama" >/dev/null 2>&1; then

        log_info "Starting Ollama..."

        ollama serve >/dev/null 2>&1 &

        sleep 5

    fi

    #
    # Models
    #
    local models=(
        "qwen3:8b"
        "llama3.3"
        "nomic-embed-text"
    )

    for model in "${models[@]}"; do

        if ollama list | awk '{print $1}' | grep -qx "${model}"; then

            log_info "Already installed: ${model}"

        else

            log_info "Pulling ${model}"

            ollama pull "${model}"

        fi

    done

    #
    # Create Configuration Directory
    #
    mkdir -p "${HOME}/.config/ollama"

    #
    # Copy Configuration
    #
    local source="${DOTFILES_DIR}/ollama"

    if [[ -d "${source}" ]]; then

        cp -R "${source}/." "${HOME}/.config/ollama"

        log_info "Installed Ollama configuration"

    fi

    log_success "Ollama configuration completed"

}