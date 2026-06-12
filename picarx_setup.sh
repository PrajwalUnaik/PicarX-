#!/bin/bash

# ============================================================
#  PiCar-X Full Setup Script
#  Run once after flashing your Raspberry Pi
#  Usage: chmod +x picarx_setup.sh && sudo bash picarx_setup.sh
# ============================================================

set -e  # Exit immediately on any error

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

log()  { echo -e "${GREEN}[✔] $1${NC}"; }
warn() { echo -e "${YELLOW}[!] $1${NC}"; }
fail() { echo -e "${RED}[✘] $1${NC}"; exit 1; }

# ── 1. System update ─────────────────────────────────────────
log "Updating system packages..."
sudo apt update && sudo apt upgrade -y

# ── 2. Required base packages ────────────────────────────────
log "Installing base Python packages..."
sudo apt install -y git python3-pip python3-setuptools python3-smbus

# ── 3. robot-hat ─────────────────────────────────────────────
log "Installing robot-hat..."
cd ~/
rm -rf robot-hat
git clone -b 2.5.x https://github.com/sunfounder/robot-hat.git --depth 1
cd robot-hat
sudo python3 install.py || fail "robot-hat install failed"

# ── 4. vilib ─────────────────────────────────────────────────
log "Installing vilib..."
cd ~/
rm -rf vilib
git clone https://github.com/sunfounder/vilib.git --depth 1
cd vilib
sudo python3 install.py || fail "vilib install failed"

# ── 5. picar-x ───────────────────────────────────────────────
log "Installing picar-x (this may take a while)..."
cd ~/
rm -rf picar-x
git clone -b 2.1.x https://github.com/sunfounder/picar-x.git --depth 1
cd picar-x
sudo pip3 install . --break-system-packages || fail "picar-x install failed"

# ── 6. I2S amplifier (sound) ─────────────────────────────────
log "Enabling I2S amplifier for sound..."
cd ~/robot-hat
# Auto-answer 'y' to all prompts in the script
yes y | sudo bash i2samp.sh || warn "i2samp.sh exited with a non-zero status — this can be normal. Check sound after reboot."

# ── Done ─────────────────────────────────────────────────────
echo ""
echo -e "${GREEN}============================================${NC}"
echo -e "${GREEN}  All modules installed successfully! 🎉   ${NC}"
echo -e "${GREEN}  Rebooting in 10 seconds...               ${NC}"
echo -e "${GREEN}  (Ctrl+C to cancel reboot)                ${NC}"
echo -e "${GREEN}============================================${NC}"
sleep 10
sudo reboot
