#!/usr/bin/env bash
#
# ==============================================================================
# mise
# ==============================================================================
#
# Install and configure mise.
#
# Runtime versions are managed by .mise.toml.
#
# ==============================================================================

set -Eeuo pipefail

################################################################################
# Constants
################################################################################

readonly MISE_CONFIG="${BOOTSTRAP_ROOT}/.mise.toml"

################################################################################
# Check
################################################################################

mise_exists() {

    command_exists mise

}

################################################################################
# Install
################################################################################

install_mise() {

    if mise_exists; then
        log_info "mise already installed."
        return
    fi

    log_info "Installing mise..."

    retry 3 brew install mise

    log_success "mise installed."

}

################################################################################
# Configure
################################################################################

configure_mise() {

    if [[ ! -f "${HOME}/.zshrc" ]]; then
        return
    fi

    if ! grep -q "mise activate zsh" "${HOME}/.zshrc"; then

        log_info "Configuring mise..."

        cat <<'EOF' >> "${HOME}/.zshrc"

# mise
eval "$(mise activate zsh)"

EOF

        log_success "mise shell configuration added."

    else

        log_info "mise shell configuration already exists."

    fi

}

################################################################################
# Install Runtime
################################################################################

install_mise_tools() {

    if [[ ! -f "${MISE_CONFIG}" ]]; then

        log_warn ".mise.toml not found."

        return

    fi

    log_info "Installing runtimes from .mise.toml..."

    mise install

    log_success "All runtimes installed."

}

################################################################################
# Verify
################################################################################

verify_mise() {

    require_command mise

    log_info "$(mise --version)"

    if [[ -f "${MISE_CONFIG}" ]]; then
        mise ls
    fi

}

################################################################################
# Public
################################################################################

setup_mise() {

    install_mise

    configure_mise

    install_mise_tools

    verify_mise

}