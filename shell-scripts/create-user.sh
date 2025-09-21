#!/bin/bash
#===============================================================================
# Script Name   : create-user.sh
# Description   : Creates a new user with specific attributes and directory permissions
# Author        : LePeanutButter, Lanapequin
# Created       : 2025-09-05
# License       : MIT License
#===============================================================================

# Parameters
username=$1              
group=$2               
description=$3         
home_dir=$4
shell=$5
user_perms=$6
group_perms=$7
public_html_perms=$8

# Check if shell exists and is executable
if [ -x "$shell" ]; then
    useradd -m -d "$home_dir" -s "$shell" -c "$description" -g "$group" "$username"
    
    # Set permissions for user's home directory
    chmod "$user_perms" "$home_dir"

    # Set permissions for group's home directory if it exists
    if [ -d "/home/$group" ]; then
        chmod "$group_perms" "/home/$group"
    fi

    # Create public_html directory if missing
    if [ ! -d "$home_dir/public_html" ]; then
        mkdir "$home_dir/public_html"
    fi
    
    # Set permissions for public_html
    chmod "$public_html_perms" "$home_dir/public_html"
    
    # Prompt to set password
    passwd "$username"
    clear

    # Confirm user creation
    if id "$username" &>/dev/null; then
        echo "User '$username' created successfully."
    else
        echo "ERROR: User '$username' could not be created."
    fi

else
    clear
    echo "ERROR: Shell '$shell' does not exist or is not installed. User creation aborted."
fi
