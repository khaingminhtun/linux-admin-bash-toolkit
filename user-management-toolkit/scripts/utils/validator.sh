#!/usr/bin/env bash

source "$(dirname "${BASH_SOURCE[0]}")/common.sh"

# ==================================
# Username Validation
# ==================================

validate_username() {

    local username="$1"

    if [[ -z "$username" ]]; then
        print_error "Username cannot be empty."
        return 1
    fi

    if [[ ! "$username" =~ ^[a-z_][a-z0-9_-]*$ ]]; then
        print_error "Invalid username."
        print_info "Allowed: lowercase letters, numbers, '_' and '-'."
        return 1
    fi

    return 0
}

# ==================================
# Check User Exists
# ==================================

user_exists() {

    local username="$1"

    if id "$username" &>/dev/null; then
        return 0
    else
        print_error "User '$username' does not exist."
        return 1
    fi

}

# ==================================
# Check User Does NOT Exist
# ==================================

user_not_exists() {

    local username="$1"

    if id "$username" &>/dev/null; then
        print_error "User '$username' already exists."
        return 1
    fi

    return 0
}
