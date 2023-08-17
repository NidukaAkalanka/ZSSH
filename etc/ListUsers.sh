#!/bin/bash

# Define font colors
GREEN="\e[32m"
ENDCOLOR="\e[0m"

clear

# Get a list of all users with UID >= 1000
allusers=$(awk -F: '$3>=1000 {print $1}' /etc/passwd | grep -v nobody)

# Display the list of users
echo -e "${GREEN}List of users with UID >= 1000:\n"
echo "$allusers${ENDCOLOR}"

# Return to panel
echo -e "\nPress Enter key to return to the main menu"; read
menu
