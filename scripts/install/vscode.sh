#!/usr/bin/env bash

###############################################################################
# VS Code Configuration
###############################################################################
install_extension() {

    local ext="$1"

    if code --list-extensions | grep -iq "^${ext}$"; then
        log_info "Already installed: ${ext}"
        return
    fi

    log_info "Installing: ${ext}"

    if code --install-extension "${ext}" --force; then
        log_success "Installed: ${ext}"
    else
        log_warn "Skipped: ${ext}"
    fi
}

install_vscode() {

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
    )

    local installed
    installed="$(code --list-extensions)"

}