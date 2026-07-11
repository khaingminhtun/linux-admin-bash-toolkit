#!/usr/bin/env bash

source "$(dirname "${BASH_SOURCE[0]}")/common.sh"



LOG_FILE="logs/user-management.log"


write_log() {


    local level="$1"
    local message="$2"


    local timestamp

    timestamp=$(date "+%Y-%m-%d %H:%M:%S")


    echo "$timestamp [$level] $message" >> "$LOG_FILE"


    case "$level" in

        INFO)
            print_info "$message"
            ;;

        SUCCESS)
            print_success "$message"
            ;;

        WARNING)
            print_warning "$message"
            ;;

        ERROR)
            print_error "$message"
            ;;

    esac

}
