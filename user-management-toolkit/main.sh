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

  list-users                   list users

  delete-user <username>       Delete an existing user

  user-status <username> lock    Lock user login

  user-status <username> unlock  Unlock user login
 
  reset-password <username>       Reset password

  help                        Show this help message

Examples:

  sudo ./main.sh create-user alice

EOF

}

# ==================================
# Load Modules
# ==================================

source scripts/users/create_user.sh
source scripts/users/list_users.sh
source scripts/users/delete_user.sh
source scripts/users/user_status.sh
source scripts/users/reset_password.sh

# ==================================
# Parse Command
# ==================================

COMMAND="$1"

case "$COMMAND" in

    create-user)

        create_user "$2"
        ;;
    list-users)
	list_users
	;;
    delete-user)
	 delete_user "$2"
	;;
    user-status)
          user_status "$2" "$3"
         ;;
    reset-password)
	    reset_password "$2"
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
