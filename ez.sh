#!/bin/bash
# ─────────────────────────────────────────────
# 🐋 Proxmox Installer (Docker Edition)
# Made by: NighT | Discord: Nightt.js
# Works on: Any Linux system with Docker
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
echo "║          🐋  Proxmox VE Docker Installer - NighT      ║"
echo "║                                                      ║"
echo "╚══════════════════════════════════════════════════════╝"
echo -e "${RESET}"

# ── Credits ─────────────────────────────────
echo -e "${CYAN}${BOLD}👨‍💻 Made by:${RESET} ${WHITE}NighT${RESET}"
echo -e "${CYAN}${BOLD}💬 Discord:${RESET} ${WHITE}Nightt.js${RESET}"
echo -e "${YELLOW}───────────────────────────────────────────────────────${RESET}"
sleep 0.3

# ── Check Docker ────────────────────────────
if ! command -v docker &>/dev/null; then
    echo -e "${RED}❌ Docker is not installed on this machine.${RESET}"
    read -rp "$(echo -e "${CYAN}${BOLD}Do you want to install Docker now? (y/n): ${RESET}")" docker_choice
    if [[ "$docker_choice" =~ ^[Yy]$ ]]; then
        echo -e "${YELLOW}📥 Installing Docker...${RESET}"
        curl -fsSL https://get.docker.com -o get-docker.sh
        sh get-docker.sh
        echo -e "${GREEN}✅ Docker installed successfully.${RESET}"
    else
        echo -e "${RED}❌ Docker installation skipped. Exiting script.${RESET}"
        exit 1
    fi
fi

# ── Check if Proxmox container exists ───────
if docker ps -a --format '{{.Names}}' | grep -q '^proxmoxve$'; then
    echo -e "${YELLOW}⚠️  A container named 'proxmoxve' already exists.${RESET}"
    read -rp "$(echo -e "${CYAN}${BOLD}Do you want to remove and recreate it? (y/n): ${RESET}")" recreate
    if [[ "$recreate" =~ ^[Yy]$ ]]; then
        echo -e "${RED}🗑 Removing old container...${RESET}"
        docker rm -f proxmoxve >/dev/null 2>&1
    else
        echo -e "${GREEN}✅ Using existing container.${RESET}"
        docker start proxmoxve >/dev/null 2>&1
        echo -e "${CYAN}💡 Access Proxmox Web UI at:${RESET} ${YELLOW}https://<your-ip>:8006${RESET}"
        exit 0
    fi
fi

# ── Pull and Run Proxmox Container ─────────
echo -e "${YELLOW}📦 Pulling Proxmox Docker image...${RESET}"
docker pull rtedpro/proxmox:8.4.1-arm64

echo -e "${GREEN}🚀 Starting Proxmox container...${RESET}"
docker run -itd \
  --name proxmoxve \
  --hostname pve \
  -p 8006:8006 \
  --privileged \
  rtedpro/proxmox:8.4.1-arm64 >/dev/null

# ── Confirmation ───────────────────────────
if docker ps --format '{{.Names}}' | grep -q '^proxmoxve$'; then
    echo -e "${GREEN}✅ Proxmox VE container is now running!${RESET}"
    echo -e "${CYAN}💡 Access the Web UI at:${RESET} ${YELLOW}https://<your-server-ip>:8006${RESET}"
else
    echo -e "${RED}❌ Failed to start the Proxmox container.${RESET}"
    exit 1
fi

echo ""
echo -e "${MAGENTA}───────────────────────────────────────────────────────${RESET}"
echo -e "${GREEN}${BOLD}Done!${RESET} Enjoy using Proxmox in Docker 🐋"
echo -e "${MAGENTA}───────────────────────────────────────────────────────${RESET}"
