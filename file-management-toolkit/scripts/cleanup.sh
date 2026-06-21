#!/usr/bin/env bash

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
    echo "$0 -d <directory> -t <time> -u <unit> [-l log_directory] [-h help]"
    echo ""
    echo "Units:"
    echo "  days"
    echo "  hours"
    echo "  minutes"
    echo " Options:"
    echo "     -t time according to units"
    echo "     -u units like minute , hours, days"
    echo "     -l option for logs dir"
    echo "     -h for help"

}

# =========================
# Parse args
# =========================
TARGET_DIR=""
TIME_VALUE=""
UNIT=""

while getopts "d:t:u:l:h" opt; do
    case "$opt" in
        d) TARGET_DIR="$OPTARG" ;;
        t) TIME_VALUE="$OPTARG" ;;
        u) UNIT="$OPTARG" ;;
	l) LOG_DIR="$OPTARG" ;;
        h) show_help; exit 0 ;;
        *) show_help; exit 1 ;;
    esac
done

# =========================
# Validation
# =========================
if [ -z "$TARGET_DIR" ] || [ -z "$TIME_VALUE" ] || [ -z "$UNIT" ]; then
    echo -e "${RED}Error:${NC} Missing arguments"
    show_help
    exit 1
fi

validate_directory "$TARGET_DIR"

validate_number "$TIME_VALUE"

# =========================
# Convert to minutes
# =========================
case "$UNIT" in
    days)
        MINUTES=$((TIME_VALUE * 1440))
        ;;
    hours)
        MINUTES=$((TIME_VALUE * 60))
        ;;
    minutes)
        MINUTES=$TIME_VALUE
        ;;
    *)
         print_error "Invalid unit: $UNIT"
        exit 1
        ;;
esac

#=====================
# logging
# ====================
setup_logging

# =========================
# Find files
# =========================
print_warning "Searching files older than $TIME_VALUE $UNIT..."

FILES=$(find "$TARGET_DIR" -type f -mmin +"$MINUTES")

if [ -z "$FILES" ]; then
    print_success "No files found"
    log_message "INFO" "CLEANUP | No files older than $TIME_VALUE $UNIT in $TARGET_DIR"
    exit 0
fi

echo "Files to delete:"
echo "$FILES"

# =========================
# Confirm
# =========================
read -p "Delete these files? (y/n): " CONFIRM

if [[ "$CONFIRM" != "y" ]]; then
    echo "Cancelled"
    exit 0
fi

# =========================
# Delete files
# =========================
COUNT=0

for file in $FILES; do
    rm -f "$file"
    ((COUNT++))
done

# =========================
# Organize Log Files
# =========================
log_message "SUCCESS" "CLEANUP | Deleted $COUNT files | $TIME_VALUE $UNIT"

# =========================
# Output
# =========================
print_success "Deleted $COUNT files"
print_info "Log saved to: $LOG_FILE"
