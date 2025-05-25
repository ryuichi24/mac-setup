# =============================================
# Logging and Output Utilities
# =============================================

# Text styling
BOLD='\033[1m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

log_header() {
    local msg=$1
    echo -e "\n${BOLD}${BLUE}=============== $msg ===============${NC}\n"
}

log_success() {
    local msg=$1
    local emoji=${2:-✅}
    echo -e "${GREEN}$emoji $msg${NC}"
}

log_error() {
    local msg=$1
    local emoji=${2:-❌}
    echo -e "${RED}$emoji $msg${NC}" >&2
}

log_warn() {
    local msg=$1
    local emoji=${2:-⚠️}
    echo -e "${YELLOW}$emoji  $msg${NC}"
}

log_info() {
    local msg=$1
    local emoji=${2:-ℹ️}
    echo -e "$emoji  $msg"
}
