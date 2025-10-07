#!/bin/bash

# Colors
GREEN="\e[32m"
CYAN="\e[36m"
YELLOW="\e[33m"
RED="\e[31m"
RESET="\e[0m"

# Credits
echo -e "${CYAN}Script made by NighT | Discord: Nightt.js${RESET}"

# Prompt for new hostname
read -rp "$(echo -e "${YELLOW}Enter the new hostname: ${RESET}")" new_hostname

# Menu to apply now or later
echo -e "${CYAN}Do you want to apply the new hostname now?${RESET}"
select choice in "Yes" "No"; do
    case $choice in
        Yes)
            # Apply hostname immediately
            sudo hostnamectl set-hostname "$new_hostname"
            echo -e "${GREEN}Hostname applied immediately: ${new_hostname}${RESET}"

            # Log out user
            echo -e "${RED}Logging out to apply hostname change...${RESET}"
            if command -v gnome-session-quit >/dev/null 2>&1; then
                gnome-session-quit --logout --no-prompt
            else
                pkill -KILL -u "$USER"
            fi
            break
            ;;
        No)
            # Only set hostname for next login
            sudo hostnamectl set-hostname "$new_hostname"
            echo -e "${YELLOW}Hostname will take effect on next login: ${new_hostname}${RESET}"
            break
            ;;
        *)
            echo "Invalid choice. Please select 1 or 2."
            ;;
    esac
done
