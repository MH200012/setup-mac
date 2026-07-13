#!/usr/bin/env bash
#
# ==============================================================================
# Homebrew
# ==============================================================================
#
# Install and configure Homebrew.
#
# ==============================================================================

set -Eeuo pipefail

################################################################################
# Constants
################################################################################

readonly HOMEBREW_INSTALL_URL="https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh"

################################################################################
# Check
################################################################################

brew_exists() {

    command_exists brew

}

################################################################################
# Install
################################################################################

install_homebrew() {

    if brew_exists; then
        log_info "Homebrew already installed."
        return
    fi

    log_info "Installing Homebrew..."

    NONINTERACTIVE=1 \
        /bin/bash -c \
        "$(curl -fsSL ${HOMEBREW_INSTALL_URL})"

    configure_homebrew

    log_success "Homebrew installed."

}

################################################################################
# Configure PATH
################################################################################

configure_homebrew() {

    if is_arm64; then

        eval "$(/opt/homebrew/bin/brew shellenv)"

    else

        eval "$(/usr/local/bin/brew shellenv)"

    fi

}

################################################################################
# Update
################################################################################

update_homebrew() {

    log_info "Updating Homebrew..."

    brew update

    log_success "Homebrew updated."

}

################################################################################
# Upgrade
################################################################################

upgrade_homebrew() {

    log_info "Upgrading Homebrew packages..."

    brew upgrade

    log_success "Homebrew packages upgraded."

}

################################################################################
# Cleanup
################################################################################

cleanup_homebrew() {

    log_info "Cleaning Homebrew..."

    brew cleanup
    local rc=$?

    log_info "brew cleanup exit code = ${rc}"

    if [[ $rc -eq 0 ]]; then
        log_success "Homebrew cleaned."
    else
        log_warn "brew cleanup exited with ${rc}"
    fi
}

################################################################################
# Doctor
################################################################################

doctor_homebrew() {

    log_info "Running brew doctor..."

    brew doctor || true

}

################################################################################
# Brew Bundle
################################################################################

install_brew_packages() {

    local brewfiles=(
        Brewfile
        Brewfile.dev
        Brewfile.ai
        Brewfile.database
        Brewfile.cloud
    )

    for file in "${brewfiles[@]}"; do

        [[ ! -f "${BOOTSTRAP_ROOT}/${file}" ]] && continue

        log_info "Installing ${file}"

        if ! brew bundle --file "${BOOTSTRAP_ROOT}/${file}"; then
            log_warn "${file} failed."
        fi
    done
}


################################################################################
# Verify
################################################################################

verify_homebrew() {

    require_command brew

}

################################################################################
# Public
################################################################################

setup_homebrew() {

    install_homebrew

    configure_homebrew

    update_homebrew

    install_brew_packages

    cleanup_homebrew

    doctor_homebrew

    verify_homebrew

}