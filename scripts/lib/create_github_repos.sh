#!/usr/bin/env bash

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

source "${SCRIPT_DIR}/lib/repositories.sh"

mkdir -p "$workspace"

count=$(get_repo_count)

for ((i=0; i<count; i++)); do

    repo=$(get_repo_name "$i")
    visibility=$(get_repo_visibility "$i")
    description=$(get_repo_description "$i")

    echo "Creating ${repo}"

    mkdir -p "${workspace}/${repo}"

    cd "${workspace}/${repo}"

    if [ ! -d ".git" ]; then
        git init
    fi

    if [ ! -f README.md ]; then
        echo "# ${repo}" > README.md
    fi

    git add .
    git commit -m "Initial commit" || true

    if gh repo view "${github_user}/${repo}" >/dev/null 2>&1; then
        echo "Repository already exists."
    else
        gh repo create \
            "${repo}" \
            --"${visibility}" \
            --description "${description}" \
            --source=. \
            --remote=origin \
            --push
    fi

done