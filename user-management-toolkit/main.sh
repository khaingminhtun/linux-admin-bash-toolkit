#!/usr/bin/env bash


# ==================================
# User Management Toolkit
# Main Entry Point
# ==================================

show_help() {

    cat << EOF

=========================================
      User Management Toolkit
=========================================

Usage:

  sudo ./main.sh <command> [arguments]

Commands:

  create-user <username>      Create a new user

  help                        Show this help message

Examples:

  sudo ./main.sh create-user alice

EOF

}

# ==================================
# Load Modules
# ==================================

source scripts/users/create_user.sh

# ==================================
# Parse Command
# ==================================

COMMAND="$1"

case "$COMMAND" in

    create-user)

        create_user "$2"
        ;;

    help)

        show_help
        ;;

    "")

        show_help
        ;;

    *)

        echo "Unknown command: $COMMAND"
        echo

        show_help
        exit 1
        ;;

esac
