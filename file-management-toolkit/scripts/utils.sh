#!/usr/bin/env bash

# =====================================
# Shared Utility Functions
# =====================================

# =========================
# Colors
# =========================
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'



# =========================
# Setup Logging
# =========================
setup_logging() {
    mkdir -p "$LOG_DIR"
    LOG_FILE="$LOG_DIR/operations.log"
    touch "$LOG_FILE"
}

# =========================
# Log Message
# =========================
log_message() {
    local LEVEL="$1"
    local MESSAGE="$2"

    echo "$(date '+%Y-%m-%d %H:%M:%S') | $LEVEL | $MESSAGE" \
    >> "$LOG_FILE"
}

# =========================
# Print Success
# =========================
print_success() {
    echo -e "${GREEN}$1${NC}"
}

# =========================
# Print Error
# =========================
print_error() {
    echo -e "${RED}$1${NC}"
}

# =========================
# Print Warning
# =========================
print_warning() {
    echo -e "${YELLOW}$1${NC}"
}

# =========================
# Print Info
# =========================
print_info() {
    echo -e "${BLUE}$1${NC}"
}

# =========================
# Validate Directory
# =========================
check_directory() {
   local DIR="$1"
   if [ -z "$DIR" ]; then
	   print_error "Directory required"
	   exit 1
	
   fi
}

validate_directory() {
    local DIR="$1"

    if [ ! -d "$DIR" ]; then
        print_error "Directory '$DIR' not found"
        exit 1
    fi
}

# =========================
# Validate Number
# =========================
validate_number() {
    local VALUE="$1"

    if ! [[ "$VALUE" =~ ^[0-9]+$ ]]; then
        print_error "Value must be numeric"
        exit 1
    fi
}
