#!/bin/bash

# Colors
GREEN="\e[32m"
CYAN="\e[36m"
YELLOW="\e[33m"
RESET="\e[0m"

# Credits
echo -e "${CYAN}Script made by NighT | Discord: Nightt.js${RESET}"

# Set default hostname if not provided
new_hostname="${1:-$(hostname)}"

# Set the hostname
echo -e "${YELLOW}Setting hostname to: ${new_hostname}${RESET}"
sudo hostnamectl set-hostname "$new_hostname"

# Update /etc/hosts
sudo sed -i "s/127.0.1.1\s.*/127.0.1.1\t$new_hostname/" /etc/hosts

# Display the new hostname
echo -e "${GREEN}Hostname successfully changed to: ${new_hostname}${RESET}"

# Log out the user
if command -v gnome-session-quit >/dev/null 2>&1; then
    echo -e "${CYAN}Logging out...${RESET}"
    gnome-session-quit --logout --no-prompt
else
    echo -e "${CYAN}Logging out...${RESET}"
    pkill -KILL -u "$USER"
fi
