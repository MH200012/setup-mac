#!/usr/bin/env bash

set -Eeuo pipefail

if [[ -z "${BOOTSTRAP_ROOT:-}" ]]; then
    readonly BOOTSTRAP_ROOT="$(
        cd "$(dirname "${BASH_SOURCE[0]}")/../.."
        pwd
    )"
fi

source "${BOOTSTRAP_ROOT}/scripts/common/log.sh"
source "${BOOTSTRAP_ROOT}/scripts/common/util.sh"