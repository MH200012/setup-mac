#!/usr/bin/env bash

set -Eeuo pipefail

################################################################################
# Root
################################################################################

BOOTSTRAP_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly BOOTSTRAP_ROOT

################################################################################
# Common
################################################################################

source "${BOOTSTRAP_ROOT}/scripts/common/init.sh"

################################################################################
# Install scripts
################################################################################

source "${BOOTSTRAP_ROOT}/scripts/install/homebrew.sh"
source "${BOOTSTRAP_ROOT}/scripts/install/mise.sh"
source "${BOOTSTRAP_ROOT}/scripts/install/uv.sh"
source "${BOOTSTRAP_ROOT}/scripts/install/dotfiles.sh"

log_banner

log_step "Updating Homebrew"
update_homebrew

log_step "Updating Homebrew Packages"
brew upgrade
brew cleanup

log_step "Updating mise"
mise upgrade

log_step "Updating uv Tools"
uv tool upgrade --all

log_step "Updating Dotfiles"
update_dotfiles

log_success "Update completed."