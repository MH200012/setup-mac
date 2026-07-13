#!/usr/bin/env bash
set -euo pipefail

################################################################################
# setup-mac installer
################################################################################

REPO_OWNER="MH200012"
REPO_NAME="setup-mac"

INSTALL_DIR="${HOME}/Developer"
TARGET_DIR="${INSTALL_DIR}/${REPO_NAME}"

################################################################################
# utility
################################################################################

log() {
    printf "\n\033[1;34m==>\033[0m %s\n" "$1"
}

success() {
    printf "\033[1;32m✓\033[0m %s\n" "$1"
}

################################################################################
# Xcode Command Line Tools
################################################################################

if ! xcode-select -p >/dev/null 2>&1; then
    log "Installing Xcode Command Line Tools..."
    xcode-select --install

    echo
    echo "Complete the Xcode installation."
    echo "Press ENTER when finished."
    read -r

    until xcode-select -p >/dev/null 2>&1; do
        sleep 5
    done
fi

success "Xcode Command Line Tools installed."

################################################################################
# Homebrew
################################################################################

if ! command -v brew >/dev/null 2>&1; then
    log "Installing Homebrew..."

    NONINTERACTIVE=1 /bin/bash -c \
        "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    if [[ -x /opt/homebrew/bin/brew ]]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    elif [[ -x /usr/local/bin/brew ]]; then
        eval "$(/usr/local/bin/brew shellenv)"
    fi
fi

success "Homebrew ready."

################################################################################
# Git
################################################################################

if ! command -v git >/dev/null 2>&1; then
    log "Installing Git..."
    brew install git
fi

success "Git ready."

################################################################################
# GitHub CLI
################################################################################

if ! command -v gh >/dev/null 2>&1; then
    log "Installing GitHub CLI..."
    brew install gh
fi

success "GitHub CLI ready."

################################################################################
# GitHub Login
################################################################################

if ! gh auth status >/dev/null 2>&1; then
    log "GitHub authentication required..."
    gh auth login
    gh auth setup-git
fi

success "GitHub authenticated."

################################################################################
# Clone / Update repository
################################################################################

mkdir -p "${INSTALL_DIR}"

if [[ ! -d "${TARGET_DIR}/.git" ]]; then
    log "Cloning ${REPO_NAME}..."
    git clone "https://github.com/${REPO_OWNER}/${REPO_NAME}.git" "${TARGET_DIR}"
else
    log "Updating ${REPO_NAME}..."
    git -C "${TARGET_DIR}" pull
fi

success "Repository ready."

################################################################################
# Bootstrap
################################################################################

cd "${TARGET_DIR}"

chmod +x bootstrap.sh

log "Running bootstrap.sh..."

if [[ ! -f bootstrap.sh ]]; then
    echo "bootstrap.sh not found."
    exit 1
fi

success "Environment setup completed."