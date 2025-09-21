#!/bin/bash
#===============================================================================
# Script Name   : create-group.sh
# Description   : Creates a new group on Linux (Slackware) or Solaris systems
# Author        : LePeanutButter, Lanapequin
# Created       : 2025-09-05
# License       : MIT License
#===============================================================================

# Validate arguments
if [ $# -ne 2 ]; then
    echo "Uso: $0 <group_name> <group_id>"
    exit 1
fi

group_name=$1
group_id=$2

# Check if group already exists
if grep "^$group_name:" /etc/group >/dev/null 2>&1; then
    echo "ERROR: Group '$group_name' already exists."
    exit 1
fi

# Detect operating system
SO=$(uname -s)

# Create group based on OS
if [ "$SO" = "SunOS" ]; then
    # Solaris uses -g for GID
    if groupadd -g "$group_id" "$group_name"; then
        echo "Group '$group_name' successfully created on Solaris with GID $group_id."
    else
        echo "ERROR: Failed to create group '$group_name' on Solaris."
        exit 1
    fi
else
    # Linux uses --gid
    if groupadd --gid "$group_id" "$group_name"; then
        echo "Group '$group_name' successfully created on Linux with GID $group_id."
    else
        echo "ERROR: Failed to create group '$group_name' on Linux."
        exit 1
    fi
fi
