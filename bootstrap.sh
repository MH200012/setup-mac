configure_openwebui#!/usr/bin/env bash
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

set -Eeuo pipefail

################################################################################
# Paths
################################################################################

BOOTSTRAP_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

################################################################################
# Common Libraries
################################################################################

source "${BOOTSTRAP_ROOT}/scripts/common/log.sh"
source "${BOOTSTRAP_ROOT}/scripts/common/util.sh"

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
source "${BOOTSTRAP_ROOT}/scripts/install/ai.sh"

################################################################################
# macOS
################################################################################

source "${BOOTSTRAP_ROOT}/scripts/macos/defaults.sh"

################################################################################
# Folder
################################################################################

source "${BOOTSTRAP_ROOT}/scripts/folders/create.sh"

################################################################################
# Doctor
################################################################################

source "${BOOTSTRAP_ROOT}/scripts/doctor.sh"

################################################################################
# Error Handler
################################################################################

on_error() {

    local exit_code=$?

    log_error "Bootstrap failed."
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

Repository : mac-bootstrap

============================================================

EOF

}

################################################################################
# Brew Bundle
################################################################################

log_step "Installing Homebrew"

setup_homebrew

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

    log_step "Installing GitHub CLI"
    
    setup_github_cli

    log_step "GitHub Authentication"

    github_login

    ###########################################################################
    # Dotfiles
    ###########################################################################

    log_step "Installing chezmoi"

    setup_chezmoi
    
    ###########################################################################
    # Brew
    ###########################################################################

    install_brew_packages

    configure_git

    configure_vscode

    configure_raycast

    configure_ollama

    configure_gh

    configure_huggingface

    configure_mise
    
    ###########################################################################
    # Runtime
    ###########################################################################

    log_step "Installing mise"

    setup_mise

    log_step "Installing uv"

    setup_uv

    ###########################################################################
    # Folder
    ###########################################################################

    log_step "Creating Directory Structure"

    create_developer_folders

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
    # AI
    ###########################################################################

    log_step "Installing AI Tools"

    install_ai_tools

    ###########################################################################
    # Doctor
    ###########################################################################

    log_step "Running Diagnostics"

    doctor
    
    ###########################################################################
    # Productivity
    ###########################################################################
    
    configure_vscode
    configure_raycast
    configure_rectangle
    configure_maccy
    configure_shottr
    configure_dropover
    configure_popclip
    configure_betterdisplay
    configure_stats
    configure_obsidian
    configure_notion
    configure_chatgpt
    configure_claude
    configure_ollama
    configure_ghostty
    configure_lazygit
    configure_huggingface
    configure_onepassword
    configure_zsh
    configure_starship
    configure_orbstack
    configure_openwebui
    configure_tableplus
    configure_iterm2
    configure_things
    configure_trello
    configure_jupyter
    
    ###########################################################################
    # Finish
    ###########################################################################

    log_success "Bootstrap completed successfully."

}

################################################################################
# Main
################################################################################

bootstrap "$@"