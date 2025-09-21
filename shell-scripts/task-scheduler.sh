#!/bin/sh
#===============================================================================
# Script Name   : task-scheduler.sh
# Description   : Add a cron job line to the invoking user's crontab,
#                 ensuring no duplicate entries.
# Author        : LePeanutButter, Lanapequin
# Created       : 2025-09-15
# License       : MIT License
#===============================================================================

# Exit immediately on error
set -e

TMP_CRONTAB="/tmp/cron.${USER}.$$"

cleanup() {
    [ -f "$TMP_CRONTAB" ] && rm -f "$TMP_CRONTAB"
}

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1"
}

usage() {
    cat <<EOF
Usage: $0 "<cron_schedule> <command> [args]"
Example:
  $0 "* * * * * /path/to/command arg1 arg2"

This will add the specified cron job to your crontab if it does not already exist.

Options:
  -h, --help    Show this help message and exit
EOF
}

# Traps
trap 'log "ERROR: Unexpected failure." >&2; cleanup; exit 1' ERR INT TERM
trap cleanup EXIT

# Check help
if [ "$#" -ne 1 ] || [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
    usage
    exit 1
fi

CRON_LINE=$1

# Check if line has at least 6 fields
NUM_FIELDS=$(echo "$CRON_LINE" | awk '{ print NF }')
if [ "$NUM_FIELDS" -lt 6 ]; then
    log "ERROR: Invalid cron entry. Must have at least 6 fields." >&2
    usage
    exit 1
fi

# Load existing crontab
if crontab -l > "$TMP_CRONTAB" 2>/dev/null; then
    log "Loaded existing crontab"
else
    log "No existing crontab found — starting a new one"
    > "$TMP_CRONTAB"
fi

# Check for duplicate entry (portable, POSIX)
FOUND=0
while IFS= read -r line; do
    [ "$line" = "$CRON_LINE" ] && FOUND=1 && break
done < "$TMP_CRONTAB"

if [ "$FOUND" -eq 1 ]; then
    log "Cron entry already exists; nothing to do"
    exit 0
fi

# Append and install
echo "$CRON_LINE" >> "$TMP_CRONTAB"
log "Appended new cron entry"

if crontab "$TMP_CRONTAB"; then
    log "Crontab updated successfully"
    exit 0
else
    log "ERROR: Failed to update crontab" >&2
    exit 1
fi
