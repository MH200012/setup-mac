#!/usr/bin/env bash

set -Eeuo pipefail

###############################################################################
# Install
###############################################################################

install_dotfiles() {

    if [[ ! -d "${DOTFILES_DIR}/.git" ]]; then

        log_info "Cloning dotfiles..."

        git clone "${DOTFILES_REPO}" "${DOTFILES_DIR}"

    else

        log_info "dotfiles already exist."

    fi

}

###############################################################################
# Configure
###############################################################################

configure_dotfiles() {

    if [[ "$(chezmoi source-path)" != "${DOTFILES_DIR}" ]]; then

        log_info "Initializing chezmoi..."

        chezmoi init "${DOTFILES_DIR}"

    fi

    log_info "Applying dotfiles..."

    chezmoi apply

}

###############################################################################
# Git identity
###############################################################################

configure_git_identity() {

    local local_config="${HOME}/.gitconfig.local"

    if git config --file "${local_config}" user.name >/dev/null 2>&1 \
        && git config --file "${local_config}" user.email >/dev/null 2>&1; then
        log_info "Git identity already configured locally."
        return
    fi

    if [[ ! -t 0 ]]; then
        log_warn "Git identity is not configured."
        log_warn "Set user.name and user.email in ${local_config}."
        return
    fi

    local git_name git_email github_user
    read -r -p "Git user name: " git_name
    read -r -p "Git email: " git_email
    github_user="$(get_config github_user)"

    git config --file "${local_config}" user.name "${git_name}"
    git config --file "${local_config}" user.email "${git_email}"
    git config --file "${local_config}" github.user "${github_user}"
    chmod 600 "${local_config}"

    log_success "Git identity saved to ${local_config}."

}

###############################################################################
# Update
###############################################################################

update_dotfiles() {

    if [[ ! -d "${DOTFILES_DIR}/.git" ]]; then
        return
    fi

    log_info "Updating dotfiles..."

    git -C "${DOTFILES_DIR}" pull --ff-only

    if [[ -n "$(chezmoi diff)" ]]; then
        log_info "Dotfile changes detected; applying without force."
    fi

    chezmoi apply

    log_success "Dotfiles updated."
}


###############################################################################
# Public
###############################################################################

setup_dotfiles() {

    install_dotfiles

    configure_dotfiles

    configure_git_identity

}
