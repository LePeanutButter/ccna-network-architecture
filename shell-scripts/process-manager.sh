#!/bin/bash
#===============================================================================
# Script Name   : process-manager.sh
# Description   : Interactive menu to list, search, kill, and restart processes
# Author        : LePeanutButter, Lanapequin
# Created       : 2025-09-15
# License       : MIT License
#===============================================================================

# Exit immediately on error, undefined variable, or failed pipe
set -eu
trap 'error_exit "An unexpected error occurred. Exiting."' ERR

# Logging function
log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1"
}

# Print error message and exit
error_exit() {
    log "ERROR: $1"
    exit 1
}

# Show usage/help
usage() {
    cat <<EOF
Usage: $0 [--help]
Options:
  --help        Show this help message and exit

Menu options will appear when run without arguments.
EOF
    exit 0
}

# Detect which ps flavor to use for listing CPU/MEM%
detect_ps() {
    OS=$(uname)
    case "$OS" in
        Linux)
            PS_CMD="ps -eo pid,comm,pcpu,pmem"
            FORMAT="PID   COMMAND            CPU%  MEM%"
            PS_STYLE="POSIX"
            ;;
        SunOS)
            PS_CMD="ps -eo pid,comm,pcpu,pmem"
            FORMAT="PID   COMMAND            CPU%  MEM%"
            PS_STYLE="SOLARIS"
            ;;
        *)
            # Default to BSD-style (e.g., *BSD, macOS)
            PS_CMD="ps aux"
            FORMAT="PID   COMMAND            CPU%  MEM%"
            PS_STYLE="BSD"
            ;;
    esac
}

# Display all processes with PID, name, CPU%, MEM%
show_processes() {
    log "Listing processes..."
    echo "$FORMAT"
    case "$PS_STYLE" in
        POSIX|SOLARIS)
            if [[ "$(uname)" == "SunOS" ]]; then
                $PS_CMD | tail +2 | awk '{printf "%-5s %-18s %-5s %-5s\n",$1,$2,$3,$4}'
            else
                $PS_CMD | tail -n +2 | awk '{printf "%-5s %-18s %-5s %-5s\n",$1,$2,$3,$4}'
            fi
            ;;
        BSD)
            $PS_CMD | awk 'NR>1 {printf "%-5s %-18s %-5s %-5s\n",$2,$11,$3,$4}'
            ;;
    esac
}


# Search for a process by name
search_process() {
    read -r -p "Enter process name or pattern: " PATTERN
    [[ -z "$PATTERN" ]] && error_exit "Pattern cannot be empty."
    log "Searching for processes matching '$PATTERN'..."

    case "$PS_STYLE" in
        POSIX|SOLARIS)
            if [[ "$PS_STYLE" == "SOLARIS" ]]; then
                ps -eo pid,user,pcpu,pmem,args | grep -i "$PATTERN" | grep -v grep || \
                    log "No matches found."
            else
                ps -eo pid,user,pcpu,pmem,args | grep -i -- "$PATTERN" | grep -v grep || \
                    log "No matches found."
            fi
            ;;
        BSD)
            ps aux | grep -i "$PATTERN" | grep -v grep || \
                log "No matches found."
            ;;
    esac
}


# Kill a process by PID
kill_process() {
    read -r -p "Enter PID to kill: " PID
    case "$PID" in
        ''|*[!0-9]*)
            error_exit "Invalid PID: $PID"
            ;;
    esac
    log "Killing process PID $PID..."
    kill "$PID" && log "Process $PID terminated."
}

# Restart a process by PID
restart_process() {
    read -r -p "Enter PID to restart: " PID
    case "$PID" in
        ''|*[!0-9]*)
            error_exit "Invalid PID: $PID"
            ;;
    esac
    # Fetch full command line
    if [[ "$PS_CMD" =~ "-eo" ]]; then
        CMDLINE=$(ps -p "$PID" -o args=)
    else
        CMDLINE=$(ps -p "$PID" -o args=)
    fi
    [[ -z "$CMDLINE" ]] && error_exit "Cannot determine command line for PID $PID."
    log "Restarting PID $PID with command: $CMDLINE"
    kill "$PID"
    # Give it a moment to die
    sleep 1
    # Re-launch in background
    eval "${CMDLINE} &" || error_exit "Failed to restart process."
    log "Process restarted."
}

# Main menu loop
main_menu() {
    detect_ps
    while true; do
        cat <<EOF

Process Management Menu
1) List all processes
2) Search for a process
3) Kill a process
4) Restart a process
5) Exit

EOF
        read -r -p "Choose an option [1-5]: " CHOICE
        case "$CHOICE" in
            1) show_processes ;;
            2) search_process ;;
            3) kill_process ;;
            4) restart_process ;;
            5) log "Exiting."; exit 0 ;;
            *) log "Invalid choice: $CHOICE" ;;
        esac
    done
}

# Entry point
if [[ "${1:-}" == "--help" ]]; then
    usage
elif [[ $# -gt 0 ]]; then
    usage
else
    main_menu
fi
