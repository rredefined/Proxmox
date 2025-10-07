#!/bin/bash

# Colors
GREEN="\e[32m"
CYAN="\e[36m"
YELLOW="\e[33m"
RESET="\e[0m"

# Credits
echo -e "${CYAN}Script made by NighT | Discord: Nightt.js${RESET}"

# Ask for new hostname
read -rp "$(echo -e "${YELLOW}Enter the new hostname: ${RESET}")" new_hostname

# Ask whether to update now
echo -e "${CYAN}Do you want to apply the new hostname now?${RESET}"
select choice in "Yes" "No"; do
    case $choice in
        Yes)
            sudo hostnamectl set-hostname "$new_hostname"
            echo -e "${GREEN}Hostname applied immediately: ${new_hostname}${RESET}"
            break
            ;;
        No)
            echo -e "${YELLOW}Hostname will take effect on next login/reconnect: ${new_hostname}${RESET}"
            break
            ;;
        *)
            echo "Invalid choice. Please choose 1 or 2."
            ;;
    esac
done
