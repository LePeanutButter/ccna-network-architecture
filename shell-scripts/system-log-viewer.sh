#!/bin/bash
#===============================================================================
# Script Name   : system-log-viewer.sh
# Description   : Interactive menu to view and filter system log files
# Author        : LePeanutButter, Lanapequin
# Created       : 2025-09-05
# License       : MIT License
#===============================================================================

# Exit on error or undefined variable
set -eu
trap 'error_exit "An unexpected error occurred. Exiting."' ERR


# Clear screen if supported
clear_screen() {
    command -v clear >/dev/null 2>&1 && clear
}

# Display last 15 lines of a log file
show_log() {
    file="$1"
    if [ -f "$file" ]; then
        echo "Log file: $file — Last 15 lines:"
        TAIL_CMD=$(get_tail_command)
        $TAIL_CMD "$file"
        echo "-------------------------------------------------------"
    else
        echo "Log file $file does not exist."
    fi
}

# Determine correct tail command based on OS
get_tail_command() {
    if uname | grep -qi "sunos"; then
        echo "tail -15"      # Solaris-compatible
    else
        echo "tail -n 15"    # GNU/Linux and others
    fi
}

# Display last 15 lines containing a keyword
filter_log() {
    file="$1"
    keyword="$2"
    if [ -f "$file" ]; then
        echo "Log file: $file — Lines containing \"$keyword\" in last 15:"
        TAIL_CMD=$(get_tail_command)
        $TAIL_CMD "$file" | grep "$keyword"
        echo "-------------------------------------------------------"
    else
        echo "Log file $file does not exist."
    fi
}

# Common log file paths (customize as needed)
LOGS="
/var/log/messages
/var/log/secure
/var/log/cron
/var/log/dmesg
/var/log/Xorg.0.log
/var/adm/messages
/var/adm/syslog/syslog.log
/var/adm/loginlog
/var/adm/sulog
"

# Main menu loop
while true; do
    clear_screen
    echo "Menu"
    echo "1) Show last 15 lines of all log files"
    echo "2) Show last 15 lines containing a specific word"
    echo "3) Exit"
    printf "Choose an option [1-3]: "
    read choice

    case "$choice" in
        1)
            clear_screen
            for log in $LOGS; do
                show_log "$log"
            done
            printf "Press Enter to continue..."
            read dummy
            ;;
        2)
            clear_screen
            printf "Enter keyword to search: "
            read keyword
            for log in $LOGS; do
                filter_log "$log" "$keyword"
            done
            printf "Press Enter to continue..."
            read dummy
            ;;
        3)
            clear_screen
            exit 0
            ;;
        *)
            echo "Invalid option."
            printf "Press Enter to continue..."
            read dummy
            ;;
    esac
done