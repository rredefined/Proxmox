#!/bin/bash

# Colors
GREEN="\e[32m"
CYAN="\e[36m"
YELLOW="\e[33m"
RESET="\e[0m"

# Credits
echo -e "${CYAN}Script made by NighT | Discord: Nightt.js${RESET}"

# Prompt for new hostname
read -rp "$(echo -e "${YELLOW}Enter the new hostname: ${RESET}")" new_hostname

# Set the hostname using hostnamectl
sudo hostnamectl set-hostname "$new_hostname"
echo -e "${GREEN}Hostname successfully changed to: ${new_hostname}${RESET}"

# Show current hostname immediately
echo -e "${CYAN}Current hostname is: $(hostname)${RESET}"
