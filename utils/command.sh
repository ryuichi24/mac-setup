has_command() {
    local cmd=$1
    local label=${2:-$cmd}
    if ! which ${cmd} &> /dev/null; then
        log_warn "${label} not installed"
        return 1
    fi
    log_success "${label} already installed"
    return 0
}