#!/usr/bin/env bash
#
# ==============================================================================
# uv
# ==============================================================================
#
# Install and configure uv.
#
# Python runtime is managed by mise.
# Python CLI tools are managed by uv.
#
# ==============================================================================

set -Eeuo pipefail

################################################################################
# Constants
################################################################################

readonly UV_TOOLS_FILE="${BOOTSTRAP_ROOT}/config/uv-tools.txt"

################################################################################
# Check
################################################################################

uv_exists() {

    command_exists uv

}

################################################################################
# Install
################################################################################

install_uv() {

    if uv_exists; then
        log_info "uv already installed."
        return
    fi

    log_info "Installing uv..."

    retry 3 brew install uv

    log_success "uv installed."

}

################################################################################
# Install CLI Tools
################################################################################

install_uv_tools() {

    if [[ ! -f "${UV_TOOLS_FILE}" ]]; then
        log_warn "uv-tools.txt not found."
        return
    fi

    log_info "Installing Python CLI tools..."

    while IFS= read -r tool; do

        [[ -z "${tool}" ]] && continue
        [[ "${tool}" =~ ^# ]] && continue

        log_info "Installing ${tool}"

        uv tool install "${tool}"

    done < "${UV_TOOLS_FILE}"

    log_success "Python CLI tools installed."

}

################################################################################
# Verify
################################################################################

verify_uv() {

    require_command uv

    log_info "$(uv --version)"

}

################################################################################
# Public
################################################################################

setup_uv() {

    install_uv

    install_uv_tools

    verify_uv

}