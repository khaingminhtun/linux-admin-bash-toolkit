#!/usr/bin/env bash


# =========================
# Load Shared Utilities
# =========================
source "$(dirname "$0")/utils.sh"

#=== log default dir =====
LOG_DIR="./logs"

# =========================
# Help Function
# =========================
show_help() {
    echo -e "${BLUE}Usage:${NC} $0 -d <directory> [-l log_directory]"
    echo ""
    echo "Options:"
    echo "  -d    Target directory to organize"
    echo "  -l    Custom log directory (optional)"
    echo "  -h    Show help"
}

# =========================
# Parse Arguments
# =========================
TARGET_DIR=""

while getopts "d:l:h" opt; do
    case "$opt" in
        d) TARGET_DIR="$OPTARG" ;;
        l) LOG_DIR="$OPTARG" ;;
        h) show_help; exit 0 ;;
        *) show_help; exit 1 ;;
    esac
done

# =========================
# Validate Input
# =========================
check_directory "$TARGET_DIR"

validate_directory "$TARGET_DIR"

# =========================
# Setup Logging
# =========================
setup_logging

# =========================
# Start Organizing
# =========================
print_warning "Organizing files in: $TARGET_DIR"

COUNT=0

for file in "$TARGET_DIR"/*; do

    # Skip directories
    [ -d "$file" ] && continue

    filename=$(basename "$file")

    extension="${filename##*.}"

    # =========================
    # Detect File Category
    # =========================
    case "$extension" in

        jpg|jpeg|png|gif)
            DEST="$TARGET_DIR/Images"
            ;;

        pdf)
            DEST="$TARGET_DIR/PDFs"
            ;;

        mp4|mkv|avi)
            DEST="$TARGET_DIR/Videos"
            ;;

        txt)
            DEST="$TARGET_DIR/Text"
            ;;

        zip|tar|gz)
            DEST="$TARGET_DIR/Archives"
            ;;

        *)
            DEST="$TARGET_DIR/Others"
            ;;
    esac

    # =========================
    # Create Destination Folder
    # =========================
    mkdir -p "$DEST"

    # =========================
    # Move Files
    # =========================
    mv "$file" "$DEST/"

    echo -e "${GREEN}Moved:${NC} $filename -> $DEST"

    ((COUNT++))

done

# =========================
# Organize Log Files
# =========================
echo "$(date '+%Y-%m-%d %H:%M:%S') | ORGANIZE SUCCESS | $COUNT files organized" \
>> "$LOG_FILE"

# =========================
# Final Output
# =========================
echo ""
print_success "Organization Complete"
print_success "Files Organized: $COUNT"
print_info "Log File: $LOG_FILE"
