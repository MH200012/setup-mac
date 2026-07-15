#!/usr/bin/env bash
set -Eeuo pipefail

################################################################################
# Build dotfiles repository
################################################################################

DOTFILES="${HOME}/Developer/dotfiles"

echo "Building dotfiles..."

rm -rf "${DOTFILES}"

mkdir -p "${DOTFILES}"

################################################################################
# helper
################################################################################

copy_file() {

    local src="$1"
    local dst="$2"

    if [[ -f "$src" ]]; then

        mkdir -p "$(dirname "${DOTFILES}/${dst}")"

        cp "$src" "${DOTFILES}/${dst}"

        echo "Added ${dst}"

    fi

}

################################################################################
# helper
################################################################################

copy_dir() {

    local src="$1"
    local dst="$2"

    if [[ -d "$src" ]]; then

        mkdir -p "${DOTFILES}/${dst}"

        cp -R "$src"/. "${DOTFILES}/${dst}"

        echo "Added ${dst}"

    fi

}

################################################################################
# dotfiles
################################################################################

copy_file ~/.gitconfig \
    dot_gitconfig

copy_file ~/.zshrc \
    dot_zshrc

copy_file ~/.zprofile \
    dot_zprofile

copy_file ~/.config/starship.toml \
    dot_config/starship.toml

copy_dir ~/.config/ghostty \
    dot_config/ghostty

copy_dir ~/.config/lazygit \
    dot_config/lazygit

copy_dir ~/.config/raycast \
    dot_config/raycast

copy_dir ~/.config/gitui \
    dot_config/gitui

copy_dir ~/.config/bat \
    dot_config/bat

copy_dir ~/.config/atuin \
    dot_config/atuin

copy_dir ~/.config/mise \
    dot_config/mise

copy_dir ~/.config/gh \
    dot_config/gh

copy_dir ~/.config/uv \
    dot_config/uv

################################################################################
# ssh
################################################################################

copy_file ~/.ssh/config \
    private_dot_ssh/config

################################################################################
# README
################################################################################

cat > "${DOTFILES}/README.md" <<EOF
Generated automatically.

Do not edit directly.

Run:

scripts/dotfiles/build.sh
EOF

echo
echo "Done."