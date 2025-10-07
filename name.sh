#!/bin/bash

# Colors
GREEN="\e[32m"
CYAN="\e[36m"
YELLOW="\e[33m"
RESET="\e[0m"

# Credits
echo -e "${CYAN}Script made by NighT | Discord: Nightt.js${RESET}"

# Ask user for the new hostname with colored prompt
read -rp "$(echo -e "${YELLOW}Enter the new hostname: ${RESET}")" new_hostname

# Set the hostname
sudo hostnamectl set-hostname "$new_hostname"
echo -e "${GREEN}Hostname changed to ${new_hostname}${RESET}"

# Attempt to log out the current user and restart session
if command -v gnome-session-quit >/dev/null 2>&1; then
    # For GNOME desktop
    echo -e "${CYAN}Logging out...${RESET}"
    gnome-session-quit --logout --no-prompt
else
    # Fallback: kill all processes of current user (forces logout)
    echo -e "${CYAN}Restarting session...${RESET}"
    pkill -KILL -u "$USER"
fi
