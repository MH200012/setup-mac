#!/usr/bin/env bash

set -Eeuo pipefail

configure_granola() {

    local app="/Applications/Granola.app"

    if [[ ! -d "${app}" ]]; then
        log_warn "Granola is not installed."
        return
    fi

    log_info "Granola installed."

    # 必要なら初回起動
    open -ga "Granola" || true
}

setup_granola() {

    configure_granola

}