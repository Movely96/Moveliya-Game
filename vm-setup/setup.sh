#!/bin/bash
# Moveliya Game - Ubuntu/Debian VM setup.
# Builds the same lab as the Docker path, but directly on the machine.
# Run inside a throwaway VM, then delete the repo (see README).
#
# Cross-platform players do NOT need this script - use `docker compose up --build`.
set -e

echo "   MOVELIYA GAME - Lab Setup Script"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

# ---- Step 1: Install packages ----
echo "[*] Installing Apache, PHP and OpenSSH (this may take a minute)..."
sudo apt update -qq
sudo apt install -y apache2 php libapache2-mod-php php-cli openssh-server -qq
sudo systemctl enable apache2 -q
sudo systemctl start apache2
sudo systemctl enable ssh -q 2>/dev/null || sudo systemctl enable sshd -q 2>/dev/null || true
sudo systemctl start ssh 2>/dev/null || sudo systemctl start sshd 2>/dev/null || true

# ---- Step 2: Create accounts + hidden portal files (shared script) ----
echo "[*] Creating user accounts and hidden files..."
sudo bash "$REPO_ROOT/ssh/create-users.sh"

# ---- Step 3: Deploy the website (shared source in web/) ----
echo "[*] Deploying GCE website..."
sudo cp "$REPO_ROOT/web/robots.txt" /var/www/html/robots.txt
sudo rm -rf /var/www/html/gce
sudo cp -r "$REPO_ROOT/web/gce" /var/www/html/gce
sudo chown -R www-data:www-data /var/www/html/gce
sudo chmod -R 755 /var/www/html/gce

echo "   SETUP COMPLETE"
echo "   Web portal: http://localhost/gce/home.php"
echo "   SSH:        ssh <user>@localhost"
echo "   Time to start investigating."
