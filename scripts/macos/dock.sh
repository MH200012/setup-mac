#!/usr/bin/env bash

set -Eeuo pipefail

readonly DOCK_CONFIG="${BOOTSTRAP_ROOT}/config/dock.toml"

################################################################################
# Read dock.toml
################################################################################

get_dock_apps() {

    python3 - "${DOCK_CONFIG}" <<'PY'
import re
import sys

config_path = sys.argv[1]

try:
    import tomllib
except ModuleNotFoundError:
    # macOS system Python is currently 3.9 and does not include tomllib.
    with open(config_path, encoding="utf-8") as f:
        content = f.read()

    apps_block = re.search(r"(?ms)^\s*apps\s*=\s*\[(.*?)^\s*\]", content)
    if apps_block is None:
        raise ValueError("apps array not found")

    apps = []
    for line in apps_block.group(1).splitlines():
        line = line.strip()
        if not line or line.startswith("#"):
            continue

        app = re.fullmatch(r'(["\'])(.*)\1\s*,?\s*(?:#.*)?', line)
        if app is None:
            raise ValueError(f"invalid app entry: {line}")
        apps.append(app.group(2))
else:
    with open(config_path, "rb") as f:
        apps = tomllib.load(f)["apps"]

for app in apps:
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

        dockutil --add "${app}" --replacing "$(basename "${app}" .app)" --no-restart

    else

        log_warn "$(basename "${app}") not installed. Skipping."

    fi

}

################################################################################
# Configure Dock
################################################################################

setup_dock() {

    log_step "Configuring Dock"

    # Resolve the configuration before removing the existing Dock entries.
    # This prevents a missing Python module or invalid TOML file from clearing
    # the Dock without adding the configured applications back.
    local apps
    apps="$(get_dock_apps)"

    if [[ -z "${apps}" ]]; then

        log_warn "No Dock applications configured. Skipping."

        return

    fi

    #
    # Finderは削除されないので追加しない
    #
    dockutil --remove all --no-restart

    while IFS= read -r app; do

        [[ -z "${app}" ]] && continue

        add_dock_app "${app}"

    done <<< "${apps}"

    killall Dock

    log_success "Dock configured."

}
