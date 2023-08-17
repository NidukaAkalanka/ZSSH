#!/bin/bash

# Define font colors
RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
ENDCOLOR="\e[0m"

clear

# Get user input
echo -ne "${YELLOW}Enter the username: "; read username
while true; do
    read -p "Do you want to generate a random password? (Y/N) " yn
    case $yn in
        [Yy]* ) password=$(< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c${1:-9};echo;); break;;
        [Nn]* ) echo -ne "Enter password (please use a strong password): "; read password; break;;
        * ) echo "Please answer yes or no.";;
    esac
done
echo -ne "Enter the number of days till expiration: "; read nod
exd=$(date +%F -d "$nod days")

# Modify user details
chage -E $exd $username && echo "$username:$password" | chpasswd &&
clear &&
echo -e "${GREEN}User Details" &&
echo -e "${RED}------------" &&
echo -e "${GREEN}\nUsername: ${YELLOW}$username" &&
echo -e "${GREEN}\nPassword: ${YELLOW}$password" &&
echo -e "${GREEN}\nExpire Date: ${YELLOW}$exd ${ENDCOLOR}" ||
echo -e "${RED}\nFailed to modify user $username. Please try again.${ENDCOLOR}"

# Return to panel
echo -e "\nPress Enter key to return to the main menu"; read
menu
