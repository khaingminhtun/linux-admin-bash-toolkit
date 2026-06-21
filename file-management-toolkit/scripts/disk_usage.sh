#!/usr/bin/env bash


# =========================
# Load Shared Utilities
# =========================
source "$(dirname "$0")/utils.sh"

# =========================
# Defaults
# =========================
LOG_DIR="./logs"
TOP_N=10

# =========================
# Help Function
# =========================
show_help() {
    echo -e "${BLUE}Usage:${NC}"
    echo "$0 -d <directory> [-n top_results] [-l log_dir]"
    echo ""
    echo "Options:"
    echo "  -d    Target directory"
    echo "  -n    Number of results to display"
    echo "  -l    Custom log directory"
    echo "  -h    Show help"
}

# =========================
# Parse Arguments
# =========================
TARGET_DIR=""

while getopts "d:n:l:h" opt; do
    case "$opt" in
        d) TARGET_DIR="$OPTARG" ;;
        n) TOP_N="$OPTARG" ;;
        l) LOG_DIR="$OPTARG" ;;
        h) show_help; exit 0 ;;
        *) show_help; exit 1 ;;
    esac
done

# =========================
# Validation
# =========================
check_directory "$TARGET_DIR"

validate_directory "$TARGET_DIR"

validate_number "$TOP_N"

# =========================
# Setup Logging
# =========================
setup_logging

# =========================
# Analyze Disk Usage
# =========================
print_warning "Analyzing disk usage...${NC}"
echo ""

RESULTS=$(du -ah "$TARGET_DIR" 2>/dev/null | sort -rh | head -n "$TOP_N")

if [ -z "$RESULTS" ]; then
    print_error "No results found.${NC}"
    exit 1
fi

# =========================
# Display Results
# =========================
print_success "Top $TOP_N Largest Files/Folders:${NC}"
echo ""

echo "$RESULTS"

# =========================
# Logging
# =========================

log_message "INFO" " DISK USAGE | $TARGET_DIR | Top $TOP_N"


# =========================
# Final Output
# =========================
echo ""
print_info "Log File:${NC} $LOG_FILE"
