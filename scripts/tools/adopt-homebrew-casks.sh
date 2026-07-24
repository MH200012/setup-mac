#!/usr/bin/env bash

set -Eeuo pipefail

###############################################################################
# Homebrew Cask Adoption
#
# Reinstall manually-installed applications so that they become managed
# by Homebrew.
###############################################################################

readonly CASKS=(
    chatgpt
    chatgpt-atlas
    claude
    open-webui
    jupyterlab-app
    lm-studio
    macwhisper

    raycast
    rectangle
    maccy
    shottr
    popclip
    betterdisplay
    obsidian
    notion
    notion-calendar

    slack
    discord
    zoom

    trello

    coteditor

    vlc
    spotify
    postman
    wireshark
    visualvm

    1password
    1password-cli
    stats

    granola
)

###############################################################################

echo
echo "==========================================="
echo " Homebrew Cask Adoption"
echo "==========================================="
echo

for cask in "${CASKS[@]}"; do

    printf "%-25s" "${cask}"

    #
    # Already managed
    #
    if brew list --cask "${cask}" >/dev/null 2>&1; then
        echo "✓ managed"
        continue
    fi

    #
    # Install / Adopt
    #
    if brew install --cask "${cask}"; then
        echo "✓ adopted"
    else
        echo "✗ failed"
    fi

done

echo
echo "Done."