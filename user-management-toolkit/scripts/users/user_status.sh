#!/usr/bin/env bash

COMMON_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"


source "$COMMON_DIR/../utils/common.sh"
source "$COMMON_DIR/../utils/logger.sh"
source "$COMMON_DIR/../utils/validator.sh"
source "$COMMON_DIR/../utils/permission_check.sh"


user_status() {

    local username="$1"
    local action="$2"


    check_root_permission


    validate_username "$username" || return 1


    user_exists "$username" || return 1



    case "$action" in


        lock)

            if usermod -L "$username"; then

                write_log "SUCCESS" "User '$username' locked successfully."

            else

                write_log "ERROR" "Failed to lock user '$username'."
                return 1

            fi

            ;;



        unlock)

            if usermod -U "$username"; then

                write_log "SUCCESS" "User '$username' unlocked successfully. "

		write_log "WARNING" "Now Set Password for '$username' fornew login after unlock"
            else

                write_log "ERROR" "Failed to unlock user '$username'."
                return 1

            fi

            ;;



        *)

            print_error "Invalid action."
            print_info "Use: lock or unlock"

            return 1

            ;;

    esac

}
