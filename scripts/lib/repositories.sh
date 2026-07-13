#!/usr/bin/env bash

CONFIG_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../config" && pwd)"
CONFIG_FILE="${CONFIG_DIR}/repositories.toml"

if ! command -v yq >/dev/null; then
    echo "Please install yq"
    exit 1
fi

github_user=$(yq '.github_user' "$CONFIG_FILE" | tr -d '"')

workspace=$(yq '.workspace' "$CONFIG_FILE" | tr -d '"')

get_repo_count() {
    yq '.repository | length' "$CONFIG_FILE"
}

get_repo_name() {
    yq ".repository[$1].name" "$CONFIG_FILE" | tr -d '"'
}

get_repo_visibility() {
    yq ".repository[$1].visibility" "$CONFIG_FILE" | tr -d '"'
}

get_repo_description() {
    yq ".repository[$1].description" "$CONFIG_FILE" | tr -d '"'
}