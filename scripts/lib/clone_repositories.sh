#!/usr/bin/env bash

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

source "${SCRIPT_DIR}/lib/repositories.sh"

mkdir -p "$workspace"

count=$(get_repo_count)

cd "$workspace"

for ((i=0; i<count; i++)); do

    repo=$(get_repo_name "$i")

    if [ -d "$repo/.git" ]; then
        echo "${repo} already cloned."
        continue
    fi

    gh repo clone "${github_user}/${repo}"

done