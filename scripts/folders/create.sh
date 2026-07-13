#!/usr/bin/env bash

set -Eeuo pipefail

create_folders() {

    log_step "Creating workspace folders"

    mkdir -p "$HOME/Developer"

    mkdir -p "$HOME/Developer/Projects"
    mkdir -p "$HOME/Developer/Repositories"
    mkdir -p "$HOME/Developer/Sandbox"

    mkdir -p "$HOME/Documents/Notes"
    mkdir -p "$HOME/Documents/Books"

    mkdir -p "$HOME/Datasets"
    mkdir -p "$HOME/Models"

    log_success "Workspace folders created."
    
}