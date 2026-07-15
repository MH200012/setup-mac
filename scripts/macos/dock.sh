#!/usr/bin/env bash

set -Eeuo pipefail

readonly DOCK_CONFIG="${BOOTSTRAP_ROOT}/config/dock.toml"

################################################################################
# Read dock.toml
################################################################################

get_dock_apps() {

    python3 - "${DOCK_CONFIG}" <<'PY'
import tomllib
import sys

with open(sys.argv[1], "rb") as f:
    data = tomllib.load(f)

for app in data["apps"]:
    print(app)
PY

}

################################################################################
# Add Application
################################################################################

add_dock_app() {

    local app="$1"

    if [[ -d "${app}" ]]; then

        log_info "Adding $(basename "${app}")"

        dockutil --add "${app}" --no-restart

    else

        log_warn "$(basename "${app}") not installed. Skipping."

    fi

}

################################################################################
# Configure Dock
################################################################################

setup_dock() {

    log_step "Configuring Dock"

    #
    # Finderは削除されないので追加しない
    #
    dockutil --remove all --no-restart

    while IFS= read -r app; do

        [[ -z "${app}" ]] && continue

        add_dock_app "${app}"

    done < <(get_dock_apps)

    killall Dock

    log_success "Dock configured."

}