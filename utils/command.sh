has_command() {
    local cmd=$1
    local label=${2:-$cmd}
    if ! which ${cmd} &> /dev/null; then
        log_warn "${label} not found"
        return 1
    fi
    log_success "${label} found"
    return 0
}