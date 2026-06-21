#!/usr/bin/env bash


# =========================
# Load Shared Utilities
# =========================
source "$(dirname "$0")/utils.sh"


# =========================
# Defaults
# =========================
LOG_DIR="./logs"

# =========================
# Help
# =========================
show_help() {
    echo -e "${BLUE}Usage:${NC}"
    echo "$0 -d <directory> [-n filename] [-c content]"
    echo ""
    echo "Options:"
    echo "  -d    Target directory"
    echo "  -n    Search by filename"
    echo "  -c    Search by file content"
    echo "  -l    Custom log directory"
    echo "  -h    Show help"
}

# =========================
# Parse Arguments
# =========================
TARGET_DIR=""
NAME_SEARCH=""
CONTENT_SEARCH=""

while getopts "d:n:c:l:h" opt; do
    case "$opt" in
        d) TARGET_DIR="$OPTARG" ;;
        n) NAME_SEARCH="$OPTARG" ;;
        c) CONTENT_SEARCH="$OPTARG" ;;
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


if [ -z "$NAME_SEARCH" ] && [ -z "$CONTENT_SEARCH" ]; then
    print_error " Provide -n or -c search option"
    exit 1
fi

# =========================
# Setup Logging
# =========================
setup_logging

# =========================
# Filename Search
# =========================
if [ -n "$NAME_SEARCH" ]; then

    print_warning "Searching filenames for:${NC} $NAME_SEARCH"

    RESULTS=$(find "$TARGET_DIR" -type f -iname "*$NAME_SEARCH*")

    if [ -z "$RESULTS" ]; then
        print_error "No matching files found."
    else
        print_success "Matching files."
        echo "$RESULTS"
    fi

    log_message "SUCCESS" "SEARCH NAME | $NAME_SEARCH" 

fi

# =========================
# Content Search
# =========================
if [ -n "$CONTENT_SEARCH" ]; then

    print_warning "Searching file contents for:${NC} $CONTENT_SEARCH"

    RESULTS=$(grep -r -l "$CONTENT_SEARCH" "$TARGET_DIR" 2>/dev/null)

    if [ -z "$RESULTS" ]; then
        print_error "No matching content found.${NC}"
    else
        print_success "Matching content files:${NC}"
        echo "$RESULTS"
    fi

    log_message "SUCCESS"  "SEARCH CONTENT | $CONTENT_SEARCH"

    
fi
