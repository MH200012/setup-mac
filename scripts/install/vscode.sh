#!/usr/bin/env bash

###############################################################################
# VS Code Configuration
###############################################################################

configure_vscode() {

    log_step "Configuring Visual Studio Code"

    #
    # VS Code がインストールされているか確認
    #
    if ! command -v code >/dev/null 2>&1; then
        log_warn "VS Code CLI (code) not found."
        log_warn "Launch VS Code once and install the Shell Command:"
        log_warn "Command Palette -> 'Shell Command: Install code command in PATH'"
        return 0
    fi

    #
    # Extensions
    #
    local extensions=(
        # Python
        "ms-python.python"
        "ms-python.vscode-pylance"
        "ms-python.debugpy"

        # Jupyter
        "ms-toolsai.jupyter"
        "ms-toolsai.jupyter-keymap"
        "ms-toolsai.jupyter-renderers"

        # GitHub
        "GitHub.copilot"
        "GitHub.copilot-chat"
        "GitHub.vscode-pull-request-github"

        # Docker
        "ms-azuretools.vscode-docker"

        # Remote
        "ms-vscode-remote.remote-containers"
        "ms-vscode-remote.remote-ssh"

        # YAML
        "redhat.vscode-yaml"

        # TOML
        "tamasfe.even-better-toml"

        # JSON
        "zainchen.json"

        # Markdown
        "yzhang.markdown-all-in-one"

        # Git
        "eamodio.gitlens"

        # Editor
        "EditorConfig.EditorConfig"

        # AI
        "Continue.continue"

        # Database
        "mtxr.sqltools"

        # Terraform
        "hashicorp.terraform"
    )

    local installed
    installed="$(code --list-extensions)"

    for ext in "${extensions[@]}"; do
        if echo "${installed}" | grep -iq "^${ext}$"; then
            log_info "Already installed: ${ext}"
        else
            log_info "Installing: ${ext}"
            code --install-extension "${ext}" --force
        fi
    done

    #
    # settings.json
    #
    local settings_source="${DOTFILES_DIR}/vscode/settings.json"
    local settings_dest="${HOME}/Library/Application Support/Code/User/settings.json"

    if [[ -f "${settings_source}" ]]; then

        mkdir -p "$(dirname "${settings_dest}")"

        cp "${settings_source}" "${settings_dest}"

        log_info "Installed settings.json"

    fi

    #
    # snippets
    #
    local snippet_source="${DOTFILES_DIR}/vscode/snippets"

    local snippet_dest="${HOME}/Library/Application Support/Code/User/snippets"

    if [[ -d "${snippet_source}" ]]; then

        mkdir -p "${snippet_dest}"

        cp -R "${snippet_source}/." "${snippet_dest}"

        log_info "Installed snippets"

    fi

    log_success "VS Code configuration completed"

}