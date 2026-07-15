#!/usr/bin/env bash

set -Eeuo pipefail

#
# 多重読み込み防止
#
if [[ -n "${SETUP_MAC_CONSTANTS_LOADED:-}" ]]; then
    return 0
fi
readonly SETUP_MAC_CONSTANTS_LOADED=1

################################################################################
# Directories
################################################################################

readonly DEVELOPER_DIR="${HOME}/Developer"

readonly SETUP_MAC_DIR="${DEVELOPER_DIR}/setup-mac"

readonly DOTFILES_DIR="${DEVELOPER_DIR}/dotfiles"

readonly CONFIG_DIR="${SETUP_MAC_DIR}/config"

readonly LOG_DIR="${SETUP_MAC_DIR}/logs"

################################################################################
# Repositories
################################################################################

readonly DOTFILES_REPO="https://github.com/MH200012/dotfiles.git"

readonly SETUP_MAC_REPO="https://github.com/MH200012/setup-mac.git"