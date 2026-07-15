#!/usr/bin/env bash

set -Eeuo pipefail

#
# BOOTSTRAP_ROOT
#
if [[ -z "${BOOTSTRAP_ROOT:-}" ]]; then
    readonly BOOTSTRAP_ROOT="$(
        cd "$(dirname "${BASH_SOURCE[0]}")/../.."
        pwd
    )"
fi

#
# Constants（最初）
#
source "${BOOTSTRAP_ROOT}/scripts/common/constants.sh"

#
# Utilities
#
source "${BOOTSTRAP_ROOT}/scripts/common/log.sh"
source "${BOOTSTRAP_ROOT}/scripts/common/util.sh"