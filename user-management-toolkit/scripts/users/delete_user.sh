#!/usr/bin/env bash

COMMON_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"


source "$COMMON_DIR/../utils/common.sh"
source "$COMMON_DIR/../utils/logger.sh"
source "$COMMON_DIR/../utils/validator.sh"
source "$COMMON_DIR/../utils/permission_check.sh"

delete_user() {
	
	local username="$1"

	check_root_permission

	validate_username "$username" || return 1

	 user_exists "$username" || return 1

	 read -rp "Are you sure you want to delete '$username'? (y/N):" answer

	 answer="${answer,,}"

	 if [[ "$answer" != "y" && "$answer" != "yes" ]];then
		 
		 print_info "Operation cancelled."

		 return 0
         fi

	 userdel -r "$username" 2> /dev/null
         exit_code=$?

       # 0 = Perfect success, 12 = Success but mail spool/home dir warning
     if [ $exit_code -eq 0 ] || [ $exit_code -eq 12 ]; then
             write_log "SUCCESS" "User '$username' deleted successfully."
     else
             write_log "ERROR" "Failed to delete user '$username' (Exit Code: $exit_code)."
     return 1
    fi


}




