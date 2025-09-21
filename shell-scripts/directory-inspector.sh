#!/bin/bash
#===============================================================================
# Script Name   : directory-inspector.sh
# Description   : Interactive menu to sort and filter files in a given directory
# Author        : LePeanutButter, Lanapequin
# Created       : 2025-09-05
# License       : MIT License
#===============================================================================

# List all files, directories, and symlinks at depth 1 (including hidden)
list_items() {
    for f in "$1"/* "$1"/.*; do
        base=$(basename "$f")
        [ "$base" = "." ] && continue
        [ "$base" = ".." ] && continue
        [ -e "$f" ] || continue
        echo "$f"
    done
}

# Get file date in YYYYMMDD format (Solaris and Linux compatible)
get_date() {
    f="$1"
    if stat -f "%Sm" -t "%Y%m%d" "$f" >/dev/null 2>&1; then
        stat -f "%Sm" -t "%Y%m%d" "$f"
    else
        stat --format="%y" "$f" 2>/dev/null | cut -c1-10 | tr -d '-'
    fi
}

# Get file size in bytes
get_size() {
    f="$1"
    wc -c <"$f" 2>/dev/null
}

# Validate input
if [ -z "$1" ]; then
    echo "Usage: $0 <path>"
    exit 1
fi

path=$1

if [ ! -d "$path" ]; then
    echo "ERROR: Provided path is not a valid directory."
    exit 1
fi

while :; do
    echo "Directory Inspector Menu"
    echo "1) Sort by attribute"
    echo "2) Filter by condition"
    echo "3) Exit"
    printf "Choose an option [1-3]: "
    read option

    case "$option" in
        1)
            echo "1) Sort by most recent (date only)"
            echo "2) Sort by oldest (date only)"
            echo "3) Sort by largest size"
            echo "4) Sort by smallest size"
            echo "5) Sort by type (file, directory, symlink)"

            printf "Choose an option [1-5]: "
            read suboption

            case "$suboption" in
                1|2)
                    list_items "$path" | while IFS= read -r f; do
                        date=$(get_date "$f")
                        echo "$date $f"
                    done | sort -r | tee /tmp/listado.tmp | cut -d' ' -f2-
                    echo ""
                    echo "Date count:"
                    cut -d' ' -f1 /tmp/listado.tmp | sort | uniq -c | sort -rn
                    rm -f /tmp/listado.tmp
                    ;;
                3|4)
                    list_items "$path" | while IFS= read -r f; do
                        if [ -f "$f" ]; then
                            size=$(get_size "$f")
                            echo "$size $f"
                        fi
                    done | sort -rn | cut -d' ' -f2-
                    ;;
                5)
                    files=0
                    directories=0
                    links=0
                    for f in "$path"/* "$path"/.*; do
                        base=$(basename "$f")
                        [ "$base" = "." ] && continue
                        [ "$base" = ".." ] && continue
                        [ -e "$f" ] || continue
                        if [ -f "$f" ]; then
                            files=$((files + 1))
                        elif [ -d "$f" ]; then
                            directories=$((directories + 1))
                        elif [ -L "$f" ]; then
                            links=$((links + 1))
                        fi
                    done
                    echo "Files: $files"
                    echo "Directories: $directories"
                    echo "Symlinks: $links"
                    ;;
                *)
                    echo "Invalid option."
                    ;;
            esac
            ;;
        2)
            clear
            printf "Include subdirectories? (y/n): "
            read recursive

            echo "1) Files starting with a string"
            echo "2) Files ending with a string"
            echo "3) Files containing a string"
            printf "Choose an option [1-3]: "
            read filter_option

            printf "Enter the string to match: "
            read pattern

            if [ "$recursive" = "s" ]; then
                case "$filter_option" in
                    1) find "$path" -type f -name "${pattern}*" ;;
                    2) find "$path" -type f -name "*${pattern}" ;;
                    3) find "$path" -type f -name "*${pattern}*" ;;
                    *) echo "Invalid option." ;;
                esac
            else
                for f in "$path"/* "$path"/.*; do
                    base=$(basename "$f")
                    [ "$base" = "." ] && continue
                    [ "$base" = ".." ] && continue
                    [ -f "$f" ] || continue
                    case "$filter_option" in
                        1)
                            case "$base" in
                                "$pattern"*) echo "$f" ;;
                            esac
                            ;;
                        2)
                            case "$base" in
                                *"$pattern") echo "$f" ;;
                            esac
                            ;;
                        3)
                            case "$base" in
                                *"$pattern"*) echo "$f" ;;
                            esac
                            ;;
                        *)
                            echo "Invalid option." ;;
                    esac
                done
            fi
            ;;
        3)
            echo "Exiting..."
            break
            ;;
        *)
            echo "Invalid option."
            ;;
    esac
done
