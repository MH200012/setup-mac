#!/usr/bin/env bash
#
# ==============================================================================
# Mac Bootstrap
# ==============================================================================
# Description:
#   Bootstrap a new macOS development environment.
#
# Usage:
#   ./bootstrap.sh
#
# ==============================================================================

set -Eeuxo pipefail

################################################################################
# Paths
################################################################################

BOOTSTRAP_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

################################################################################
# Common Libraries
################################################################################

source "${BOOTSTRAP_ROOT}/scripts/common/init.sh"

################################################################################
# Install Modules
################################################################################

source "${BOOTSTRAP_ROOT}/scripts/install/xcode.sh"
source "${BOOTSTRAP_ROOT}/scripts/install/homebrew.sh"
source "${BOOTSTRAP_ROOT}/scripts/install/git.sh"
source "${BOOTSTRAP_ROOT}/scripts/install/github_cli.sh"
source "${BOOTSTRAP_ROOT}/scripts/install/chezmoi.sh"
source "${BOOTSTRAP_ROOT}/scripts/install/mise.sh"
source "${BOOTSTRAP_ROOT}/scripts/install/uv.sh"
source "${BOOTSTRAP_ROOT}/scripts/install/vscode.sh"
source "${BOOTSTRAP_ROOT}/scripts/install/cursor.sh"
source "${BOOTSTRAP_ROOT}/scripts/install/github_cli.sh"
source "${BOOTSTRAP_ROOT}/scripts/install/macwhisper.sh"
source "${BOOTSTRAP_ROOT}/scripts/install/raycast.sh"
source "${BOOTSTRAP_ROOT}/scripts/install/dotfiles.sh"

################################################################################
# macOS
################################################################################

source "${BOOTSTRAP_ROOT}/scripts/macos/defaults.sh"
source "${BOOTSTRAP_ROOT}/scripts/macos/dock.sh"

################################################################################
# Folder
################################################################################

source "${BOOTSTRAP_ROOT}/scripts/folders/create.sh"

################################################################################
# Doctor
################################################################################

source "${BOOTSTRAP_ROOT}/scripts/doctor/doctor.sh"

################################################################################
# Error Handler
################################################################################

on_error() {

    local exit_code=$?
    local line="${BASH_LINENO[0]}"
    local cmd="${BASH_COMMAND}"

    log_error "Bootstrap failed."
    log_error "Line      : ${line}"
    log_error "Command   : ${cmd}"
    log_error "Exit code : ${exit_code}"

    exit "${exit_code}"
}

trap on_error ERR

################################################################################
# Banner
################################################################################

banner() {

cat <<EOF

============================================================

                Mac Bootstrap

============================================================

Repository : setup-mac

============================================================

EOF

}

################################################################################
# Bootstrap
################################################################################

bootstrap() {

    banner

    ###########################################################################
    # Environment
    ###########################################################################

    log_step "Checking macOS"

    check_macos

    log_step "Checking CPU Architecture"

    check_architecture

    log_step "Checking Internet"

    check_internet

    log_step "Requesting sudo"

    ensure_sudo

    ###########################################################################
    # Install
    ###########################################################################

    log_step "Installing Xcode Command Line Tools"

    install_xcode

    log_step "Installing Git"

    install_git

    log_step "GitHub CLI"

    install_github_cli

    log_step "GitHub Authentication"

    authenticate_github

    log_step "Installing Homebrew"

    setup_homebrew
    
    log_step "Installing Trello"
    
    setup_trello
    
    log_step "Installing Macwhisper"
    
    setup_macwhisper
    
    log_step "Installing Raycast"
    
    setup_raycast

    ###########################################################################
    # Dotfiles
    ###########################################################################

    log_step "Installing chezmoi"

    setup_chezmoi
    
    log_step "Installing dotfiles
    
    setup_dotfiles
        
    ###########################################################################
    # Runtime
    ###########################################################################

    log_step "Installing mise"

    setup_mise
    
    configure_mise

    log_step "Installing uv"

    setup_uv

    ###########################################################################
    # Folder
    ###########################################################################

    log_step "Creating Directory Structure"

    create_folders

    ###########################################################################
    # macOS
    ###########################################################################

    log_step "Applying macOS Settings"

    apply_macos_defaults

    ###########################################################################
    # Editors
    ###########################################################################

    log_step "Installing VS Code Extensions"

    install_vscode

    log_step "Installing Cursor"

    install_cursor

    ###########################################################################
    # Desktop
    ###########################################################################

    setup_dock

    ###########################################################################
    # Doctor
    ###########################################################################

    log_step "Running Diagnostics"

    doctor
    
    ###########################################################################
    # Finish
    ###########################################################################

    log_success "Bootstrap completed successfully."

}

################################################################################
# Main
################################################################################

bootstrap "$@"
