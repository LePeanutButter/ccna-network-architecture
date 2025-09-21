#!/bin/sh
#===============================================================================
# Script Name   : smallest-files-finder.sh
# Description   : Traverse current directory (and subdirectories), find the N
#               : smallest files whose sizes do not exceed a given max size.
#               : Outputs: filename, full path, size in bytes.
# Author        : LePeanutButter, Lanapequin
# Created       : 2025-09-15
# License       : MIT License
#===============================================================================

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1"
}

usage() {
    echo "Usage: $0 <number_of_files> <max_size>"
    echo "Example: $0 10 1GB"
    exit 1
}

[ "$#" -ne 2 ] && log "ERROR: Invalid number of arguments." && usage

num_files="$1"
raw_max_size="$2"

# Validate num_files (POSIX-safe)
case "$num_files" in
    ''|*[!0-9]*)
        log "ERROR: number_of_files must be a positive integer."
        usage
        ;;
esac

# Parse max_size
size_num=$(expr "$raw_max_size" : '\([0-9][0-9]*\)')
size_suffix=$(expr "$raw_max_size" : '[0-9][0-9]*\([A-Za-z]*\)')
size_suffix=$(echo "$size_suffix" | tr '[:lower:]' '[:upper:]')

[ -z "$size_num" ] && log "ERROR: Invalid max_size format." && usage

case "$size_suffix" in
    '') multiplier=1 ;;
    K|k) multiplier=1024 ;;
    M|m) multiplier=1048576 ;;
    G|g) multiplier=1073741824 ;;
    *) log "ERROR: Invalid size suffix '$size_suffix'."; usage ;;
esac

max_size_bytes=$(expr "$size_num" \* "$multiplier")
log "Parameters: count=$num_files, max_size=${max_size_bytes} bytes"

find . -type f -exec sh -c '
    for file; do
        [ -r "$file" ] || continue
        size=$(wc -c < "$file" | tr -d " ")
        [ "$size" -le '"$max_size_bytes"' ] && echo "$size|$file"
    done
' sh {} + | sort -t'|' -k1,1n | head -n "$num_files" | awk -F'|' '
BEGIN {
    count = 0
}
{
    fname = $2
    # Extraer el nombre del archivo sin usar arrays
    n = split(fname, segs, "/")
    name = segs[n]
    output[count] = name "\t" fname "\t" $1
    count++
}
END {
    if (count == 0) {
        print "No files found under the specified size threshold."
    } else {
        print "FILENAME\tFULL_PATH\tSIZE_BYTES"
        for (i = 0; i < count; i++) {
            print output[i]
        }
    }
}
' | tac
