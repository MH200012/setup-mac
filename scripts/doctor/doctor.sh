#!/usr/bin/env bash

set -Eeuo pipefail

doctor() {

    log_step "Running environment checks"

    check() {
        local cmd="$1"

        if command -v "$cmd" >/dev/null 2>&1; then
            log_success "$cmd: OK"
        else
            log_error "$cmd: NOT INSTALLED"
        fi
    }

    check git
    check gh
    check brew
    check mise
    check uv
    check python3

    if command -v code >/dev/null 2>&1; then
        log_success "VS Code CLI: OK"
    else
        log_warn "VS Code CLI not installed"
    fi

    if [[ -d "/Applications/Cursor.app" ]]; then
        log_success "Cursor: OK"
    else
        log_warn "Cursor not installed"
    fi

    log_success "Environment check complete."
}