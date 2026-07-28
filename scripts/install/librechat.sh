#!/usr/bin/env bash
set -euo pipefail

mkdir -p ~/Developer/services

cd ~/Developer/services

if [ ! -d LibreChat ]; then
    git clone https://github.com/danny-avila/LibreChat.git
fi

cd LibreChat

cp .env.example .env || true

docker compose up -d
