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

# Ask user if they want to apply now
echo -e "${CYAN}Do you want to apply the new hostname now? (y/n)${RESET}"
read -rp "> " choice

if [[ "$choice" =~ ^[Yy]$ ]]; then
    sudo hostnamectl set-hostname "$new_hostname"
    echo -e "${GREEN}Hostname successfully changed to: ${new_hostname}${RESET}"
    echo -e "${RED}Logging out to apply changes...${RESET}"

    # Logout user safely
    if command -v gnome-session-quit >/dev/null 2>&1; then
        gnome-session-quit --logout --no-prompt
    else
        pkill -KILL -u "$USER"
    fi
else
    sudo hostnamectl set-hostname "$new_hostname"
    echo -e "${YELLOW}Hostname will take effect on next reconnect: ${new_hostname}${RESET}"
fi

# Show current hostname
echo -e "${CYAN}Current hostname is: $(hostname)${RESET}"
