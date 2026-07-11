#!/usr/bin/env  bash


source "$(dirname "${BASH_SOURCE[0]}")/common.sh"

check_root_permission() {


    if [[ $EUID -ne 0 ]]; then

        print_error "This script must be run as root."

        print_info "Please run using sudo."

        exit 1

    fi

}
