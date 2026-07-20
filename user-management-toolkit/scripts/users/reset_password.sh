#!/usr/bin/env bash                                                                                                                         COMMON_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"                                                                                                                                                        source "$COMMON_DIR/../utils/common.sh"                               source "$COMMON_DIR/../utils/logger.sh"                               source "$COMMON_DIR/../utils/validator.sh"                            source "$COMMON_DIR/../utils/permission_check.sh" 


reset_password() {

       local username="$1"

       check_root_permission

       validate_username "$username" || return 1

       user_exists "$username" || return 1

       read -rsp "Enter new password: " password
       echo

       read -rsp "Confirm password: " confirm_password
       echo

       if [[ "$password" != "$confirm_password" ]];then
	       
	       print_error "Passwords do not match."

	       return 1
       fi


       if echo "${username}:${password}" | chpasswd; then
	       
	       write_log "SUCCESS" "Password reset for user '$username'."
       else
	       write_log "ERROR" "Failed to reset password for '$username'." 
	       return 1
       fi
}
