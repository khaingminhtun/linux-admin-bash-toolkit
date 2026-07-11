#!/usr/bin/env bash


# ==================================
# Create User
# ==================================

source "$(dirname "${BASH_SOURCE[0]}")/../utils/common.sh"
source "$(dirname "${BASH_SOURCE[0]}")/../utils/logger.sh"
source "$(dirname "${BASH_SOURCE[0]}")/../utils/validator.sh"
source "$(dirname "${BASH_SOURCE[0]}")/../utils/permission_check.sh"


create_user() {

    local username="$1"

    # Check root permission
    check_root_permission

    # Validate username
    validate_username "$username" || return 1

    # Check user does not already exist
    user_not_exists "$username" || return 1

    # Create user
    if useradd -m "$username"; then

        write_log "SUCCESS" "User '$username' created successfully."

    else

        write_log "ERROR" "Failed to create user '$username'."
        return 1

    fi

}
