#!/bin/bash

# ------------------------
# Colors
# ------------------------
bold="\033[1m"
reset="\033[0m"
blue="\033[34m"
green="\033[32m"
yellow="\033[33m"
purple="\033[35m"
cyan="\033[36m"

# ------------------------
# System Info
# ------------------------
user=$(whoami)
hostname=$(hostname)
os=$(awk -F= '/^PRETTY_NAME/ {print $2}' /etc/os-release | tr -d '"')
kernel=$(uname -r)
uptime=$(uptime -p | sed 's/up //' | sed 's/^[[:space:]]*//')
shell=$SHELL
cpu=$(lscpu | awk -F: '/Model name/ {gsub(/^ +| +$/,"",$2); print $2}')
memory=$(free -h --si | awk '/Mem:/ {print $3 "/" $2}')
disk=$(df -h / | awk 'NR==2 {print $3 "/" $2}')
host_model=$(cat /sys/class/dmi/id/product_name 2>/dev/null || echo "not specified")
bios_version=$(cat /sys/class/dmi/id/bios_version 2>/dev/null || echo "not specified")
host="$([ "$host_model" != "not specified" ] && echo "$host_model $bios_version" || echo "$host_model")"

# Public IPs
public_ipv4=$(curl -s --max-time 5 ifconfig.me || echo "N/A")
public_ipv6=$(curl -s --max-time 5 ifconfig.co/ip || echo "N/A")

# Private IPs
private_ipv4=$(hostname -I | awk '{print $1}')
private_ipv6=$(ip -6 addr show scope global | awk '/inet6/ {print $2}' | cut -d/ -f1 | head -n1)
isp=$(curl -s --max-time 5 ipinfo.io/org | sed 's/^org: //' || echo "N/A")

# ------------------------
# Neofetch-style Display
# ------------------------
echo -e "${bold}${green}$user${reset}${bold}@${blue}$hostname${reset}"
echo -e "${yellow}OS${reset}:        $os"
echo -e "${yellow}Host${reset}:      $host"
echo -e "${yellow}Kernel${reset}:    $kernel"
echo -e "${yellow}Uptime${reset}:    $uptime"
echo -e "${yellow}Shell${reset}:     $shell"
echo -e "${yellow}CPU${reset}:       $cpu"
echo -e "${yellow}Memory${reset}:    $memory"
echo -e "${yellow}Disk${reset}:      $disk"
echo -e "${yellow}Public IPv4${reset}:  $public_ipv4"
echo -e "${yellow}Public IPv6${reset}:  $public_ipv6"
echo -e "${yellow}Private IPv4${reset}: $private_ipv4"
echo -e "${yellow}Private IPv6${reset}: $private_ipv6"
echo -e "${yellow}ISP${reset}:       $isp"

# ------------------------
# Credit
# ------------------------
echo -e "\n${purple}Script made by NighT | Discord: nightt.js${reset}"
