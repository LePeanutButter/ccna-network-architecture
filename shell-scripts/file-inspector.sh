#!/bin/bash
#===============================================================================
# Script Name   : file-inspector.sh
# Description   : Interactive menu to search, count, and display lines from files
# Author        : LePeanutButter, Lanapequin
# Created       : 2025-09-05
# License       : MIT License
#===============================================================================


# Clear screen if supported
clear_screen() {
    command -v clear >/dev/null 2>&1 && clear
}

# Count occurrences of a word in a file and show matching lines
count_word_in_file() {
    file="$1"
    word="$2"

    if [ -f "$file" ]; then
        if grep "$word" "$file" >/dev/null 2>&1; then
            grep -n "$word" "$file" # Show matching lines with line numbers
            count=$(grep "$word" "$file" | tr ' ' '\n' | grep -w "$word" | wc -l)
            echo "Number of times \"$word\" appeared: $count"
        else
            echo "The word \"$word\" was not found in $file."
        fi
    else
        echo "File \"$file\" does not exist."
    fi
}

# Main menu loop
while true; do
    clear_screen
    echo "File Inspector Menu"
    echo "1) Show file paths and count matches in a directory"
    echo "2) Search for a word in a file and count occurrences"
    echo "3) Search for a word across multiple files and show matches"
    echo "4) Count number of lines in a file"
    echo "5) Show first N lines of a file"
    echo "6) Show last N lines of a file"
    echo "7) Exit"
    printf "Choose an option [1-7]: "
    read choice

    case "$choice" in
        1)
            clear_screen
            printf "Enter directory path: "
            read pathway
            printf "Enter filename pattern: "
            read file
            find "$pathway" -type f -iname "*$file*" 2>/dev/null
            count=$(find "$pathway" -type f -iname "*$file*" 2>/dev/null | wc -l)
            echo "Number of matching files: $count"
            printf "Press Enter to continue..."
            read dummy
            ;;
        2)
            clear_screen
            printf "Enter file path: "
            read file
            printf "Enter word to search: "
            read word
            count_word_in_file "$file" "$word"
            printf "Press Enter to continue..."
            read dummy
            ;;
        3)
            clear_screen
            printf "Enter directory path: "
            read pathway
            printf "Enter filename pattern: "
            read pattern
            printf "Enter word to search: "
            read word

            files=$(find "$pathway" -type f -iname "*$pattern*" 2>/dev/null)

            for file in $files; do
                grep "$word" "$file" >/dev/null 2>&1
                if [ $? -eq 0 ]; then
                    echo "===> FILE: $file <==="
                    count_word_in_file "$file" "$word"
                fi
            done
            printf "Press Enter to continue..."
            read dummy
            ;;
        4)
            clear_screen
            printf "Enter file path: "
            read file
            if [ -f "$file" ]; then
                lines=$(wc -l < "$file")
                echo "Number of lines in file: $lines"
            else
                echo "File does not exist."
            fi
            printf "Press Enter to continue..."
            read dummy
            ;;
        5)
            clear_screen
            printf "Enter file path: "
            read file
            if [ -f "$file" ]; then
                printf "How many lines to show?: "
                read n
                echo "First $n lines of file: $file"
                head -"$n" "$file" | more
            else
                echo "File does not exist."
            fi
            printf "Press Enter to continue..."
            read dummy
            ;;
        6)
            clear_screen
            printf "Enter file path: "
            read file
            if [ -f "$file" ]; then
                printf "How many lines to show?: "
                read n
                echo "Last $n lines of file: $file"
                tail -"$n" "$file" | more
            else
                echo "File does not exist."
            fi
            printf "Press Enter to continue..."
            read dummy
            ;;
        7)
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
