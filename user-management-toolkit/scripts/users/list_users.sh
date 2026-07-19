#!/usr/bin/env bash

COMMON_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"


source "$COMMON_DIR/../utils/common.sh"

list_users() {
    
	print_info "Listing regular users...."

	printf "\n%-20s %-10s %-20s\n" "USERNAME" "UID" "HOME DIRECTORY" 
	printf "%-20s %-10s %-20s\n" "_________" "___" "____________"

        awk -F: '$3 >= 1000 {
             printf "%-20s %-10s %-20s\n", $1, $3, $6      
         }' /etc/passwd
}
