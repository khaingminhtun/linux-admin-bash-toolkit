#!/usr/bin/env bash



source scripts/utils/logger.sh


write_log "INFO" "Starting user management tool"

write_log "SUCCESS" "User alice created"

write_log "WARNING" "Password expires soon"

write_log "ERROR" "User does not exist"
