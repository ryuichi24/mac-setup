# =============================================
# Logging and Output Utilities
# =============================================

# Text styling
# Text styles
BOLD='\033[1m'
UNDERLINE='\033[4m'
RESET='\033[0m'

# Regular colors
BLACK='\033[0;30m'
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[0;37m'

# Bright colors
BRIGHT_BLACK='\033[0;90m'
BRIGHT_RED='\033[0;91m'
BRIGHT_GREEN='\033[0;92m'
BRIGHT_YELLOW='\033[0;93m'
BRIGHT_BLUE='\033[0;94m'
BRIGHT_MAGENTA='\033[0;95m'
BRIGHT_CYAN='\033[0;96m'
BRIGHT_WHITE='\033[0;97m'

# Background colors (optional)
BG_RED='\033[41m'
BG_GREEN='\033[42m'
BG_YELLOW='\033[43m'
BG_BLUE='\033[44m'
BG_MAGENTA='\033[45m'
BG_CYAN='\033[46m'
BG_WHITE='\033[47m'

log_header() {
    local msg=$1
    echo -e "\n${BRIGHT_BLACK}=============== $msg ===============\n${RESET}"
}

log_success() {
    local msg=$1
    local emoji=${2:-✅}
    echo -e "${GREEN}$emoji $msg${RESET}"
}

log_error() {
    local msg=$1
    local emoji=${2:-❌}
    echo -e "${RED}$emoji $msg${RESET}" >&2
}

log_warn() {
    local msg=$1
    local emoji=${2:-⚠️}
    echo -e "${YELLOW}$emoji  $msg${RESET}"
}

log_info() {
    local msg=$1
    local emoji=${2:-ℹ️}
    echo -e "${BRIGHT_BLUE}$emoji  $msg${RESET}"
}
