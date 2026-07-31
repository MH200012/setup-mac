#!/usr/bin/env bash

CONFIG_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../config" && pwd)"
CONFIG_FILE="${CONFIG_DIR}/repositories.toml"

if ! command -v python3 >/dev/null; then
    echo "Please install Python 3"
    exit 1
fi

read_config() {
    python3 - "${CONFIG_FILE}" "$1" <<'PY'
import os
import sys

try:
    import tomllib
except ModuleNotFoundError as exc:
    raise SystemExit("Python 3.11 or newer is required") from exc

with open(sys.argv[1], "rb") as config_file:
    value = tomllib.load(config_file)[sys.argv[2]]

if isinstance(value, str):
    value = value.replace("$HOME", os.environ["HOME"])
print(value)
PY
}

github_user="$(read_config github_user)"

workspace="$(read_config workspace)"

get_repo_count() {
    python3 - "${CONFIG_FILE}" <<'PY'
import tomllib
import sys
with open(sys.argv[1], "rb") as config_file:
    print(len(tomllib.load(config_file)["repository"]))
PY
}

get_repo_name() {
    get_repo_field "$1" name
}

get_repo_visibility() {
    get_repo_field "$1" visibility
}

get_repo_description() {
    get_repo_field "$1" description
}

get_repo_field() {
    python3 - "${CONFIG_FILE}" "$1" "$2" <<'PY'
import tomllib
import sys
with open(sys.argv[1], "rb") as config_file:
    repositories = tomllib.load(config_file)["repository"]
print(repositories[int(sys.argv[2])][sys.argv[3]])
PY
}
