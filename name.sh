#!/bin/bash
# ─────────────────────────────────────────────
#  🌙 NighT Hostname Changer
#  Made by: NighT | Discord: Nightt.js
#  Works on: Ubuntu, Debian, Fedora, Arch, Proxmox & more
# ─────────────────────────────────────────────

# Colors
RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
BLUE="\e[34m"
MAGENTA="\e[35m"
CYAN="\e[36m"
WHITE="\e[97m"
RESET="\e[0m"
BOLD="\e[1m"

clear

# ── Banner ───────────────────────────────────
echo -e "${MAGENTA}${BOLD}"
echo "╔══════════════════════════════════════════════════════╗"
echo "║                                                      ║"
echo "║      🌙  NighT Hostname Changer - Linux Edition       ║"
echo "║                                                      ║"
echo "╚══════════════════════════════════════════════════════╝"
echo -e "${RESET}"
sleep 0.4

# ── Credits ─────────────────────────────────
echo -e "${CYAN}${BOLD}👨‍💻 Made by:${RESET} ${WHITE}NighT${RESET}"
echo -e "${CYAN}${BOLD}💬 Discord:${RESET} ${WHITE}Nightt.js${RESET}"
echo -e "${YELLOW}───────────────────────────────────────────────────────${RESET}"
sleep 0.3

# ── Explanation ─────────────────────────────
echo -e "${BLUE}${BOLD}💡 Example:${RESET} If your prompt looks like ${YELLOW}root@ubuntu${RESET},"
echo -e "   then your hostname is ${GREEN}ubuntu${RESET}."
echo ""
sleep 0.3

# ── Prompt for new hostname ─────────────────
echo -e "${GREEN}${BOLD}Enter the new hostname:${RESET}"
read -rp "> " new_hostname
echo ""

# Validate input
if [[ -z "$new_hostname" ]]; then
    echo -e "${RED}❌ Hostname cannot be empty!${RESET}"
    exit 1
fi

# ── Ask user to apply now ───────────────────
echo -e "${CYAN}${BOLD}Do you want to apply the new hostname now? (y/n)${RESET}"
read -rp "> " choice
echo ""

# ── Apply hostname change ───────────────────
if [[ "$choice" =~ ^[Yy]$ ]]; then
    echo -e "${YELLOW}🔧 Applying hostname...${RESET}"
    if sudo hostnamectl set-hostname "$new_hostname"; then
        echo -e "${GREEN}✅ Hostname successfully changed to:${RESET} ${YELLOW}${new_hostname}${RESET}"
        echo -e "${RED}${BOLD}Exiting shell to apply changes...${RESET}"
        sleep 2
        exit
    else
        echo -e "${RED}❌ Failed to set hostname. Make sure you have sudo privileges.${RESET}"
        exit 1
    fi
else
    if sudo hostnamectl set-hostname "$new_hostname"; then
        echo -e "${YELLOW}🕒 Hostname will take effect on next reconnect.${RESET}"
        echo -e "${CYAN}New hostname set to:${RESET} ${YELLOW}${new_hostname}${RESET}"
    else
        echo -e "${RED}❌ Failed to set hostname. Make sure you have sudo privileges.${RESET}"
        exit 1
    fi
fi

# ── Show current hostname ───────────────────
echo ""
echo -e "${BLUE}${BOLD}Current system hostname:${RESET} ${GREEN}$(hostname)${RESET}"
echo -e "${YELLOW}───────────────────────────────────────────────────────${RESET}"
