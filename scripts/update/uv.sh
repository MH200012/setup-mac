update_uv() {

    if ! uv_exists; then
        log_warn "uv is not installed."
        return
    fi

    log_info "Updating Python CLI tools..."

    uv tool upgrade --all

    log_success "Python CLI tools updated."

}