#!/usr/bin/env bash

# =========================
# Load Shared Utilities
# =========================
source "$(dirname "$0")/utils.sh"

# =========================
# Defaults
# =========================
BACKUP_DIR="./backups"

# =========================
# Help Function
# =========================
show_help() {
    echo -e "${BLUE}Usage:${NC} $0 -s <source_dir> [-b backup_dir] [-l log_dir]"
    echo ""
    echo "Options:"
    echo "  -s   Source directory (required)"
    echo "  -b   Backup directory (optional)"
    echo "  -l   Log directory (optional)"
    echo "  -h   Show help"
}

# =========================
# Parse Arguments
# =========================
SOURCE_DIR=""

while getopts "s:b:l:h" opt; do
    case "$opt" in
        s) SOURCE_DIR="$OPTARG" ;;
        b) BACKUP_DIR="$OPTARG" ;;
        l)
            LOG_DIR="$OPTARG"
            LOG_FILE="$LOG_DIR/operations.log"
            ;;
        h)
            show_help
            exit 0
            ;;
        *)
            show_help
            exit 1
            ;;
    esac
done

# =========================
# Validate Input
# =========================
if [ -z "$SOURCE_DIR" ]; then
    print_error "Source directory is required"
    show_help
    exit 1
fi

validate_directory "$SOURCE_DIR"

# =========================
# Setup Directories
# =========================
mkdir -p "$BACKUP_DIR"

setup_logging

# =========================
# Create Backup
# =========================
DIR_NAME=$(basename "$SOURCE_DIR")

TIMESTAMP=$(date +"%Y%m%d_%H%M%S")

BACKUP_FILE="$BACKUP_DIR/${DIR_NAME}_${TIMESTAMP}.tar.gz"

print_warning "Creating backup..."

# =========================
# Execute Backup
# =========================
if tar -czf "$BACKUP_FILE" "$SOURCE_DIR"; then

    print_success "Backup successful"
    print_info "Backup File: $BACKUP_FILE"

    log_message "INFO" "BACKUP SUCCESS | $BACKUP_FILE"

else

    print_error "Backup failed"

    log_message "ERROR" "BACKUP FAILED | $SOURCE_DIR"

    exit 1
fi
