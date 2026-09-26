# Beginner's Guide

Never used a virtual machine or a terminal before? Start here.

## 1. What you need

This lab runs inside a Linux virtual machine (VM). Your own computer
can be Windows, macOS, or Linux - it doesn't matter, because
everything happens inside the VM, completely separate from your
real system.

- At least 4GB of free RAM and 20GB of free disk space
- An Ubuntu 24.04 Desktop ISO file:
  https://ubuntu.com/download/desktop

### If you use Windows:
Download and install VirtualBox/ Vmware Workstation

### If you use macOS:
Download and install VirtualBox:
(Choose "macOS / Intel hosts". If you have an Apple Silicon Mac -
M1/M2/M3 - VirtualBox support is limited; UTM is a good free
alternative: https://mac.getutm.app/)

### If you use Linux:
Install VirtualBox/ VMware Workstation from your package manager, for example:
```bash
sudo apt install virtualbox -y
```

## 2. Create your virtual machine

1. Open VirtualBox (or UTM on Apple Silicon Macs)
2. Click "New" and select your downloaded Ubuntu ISO file
3. Give the VM at least 2 CPU cores, 4GB RAM, and 20GB storage
4. Follow the installer prompts (choose any username/password)
5. Once installed, boot into your new Ubuntu system

Everything from here on happens inside this Ubuntu VM, not on your
real computer.

## 3. Open a terminal

On Ubuntu, press Ctrl + Alt + T, or search for "Terminal" in the
app menu.


## 4. Clone this repository

```bash
sudo apt update
sudo apt install git -y
git clone <repo-url>
cd moveliya-game
```

## 5. Run the setup script

```bash
cd vm-setup
chmod +x setup.sh
./setup.sh
```

This will take a minute or two. It creates the lab accounts and
builds the web portal automatically.

## 6. Tools you'll use

**nmap** - scans a machine to find open ports and services
```bash
sudo apt install nmap -y
nmap localhost
```

Once you find a web port open, check for a robots.txt file - it's
a real file websites use to tell search engines which pages not to
index.
or simply visit it in your browser:


**hydra** - tries many username/password combinations against a
login form (only use this on your own lab, never on real systems)
```bash
sudo apt install hydra -y
```

## 7. Basic commands you'll need

**Switch to another user account (once you have a password):**
```bash
su - username
```

**List all files, including hidden ones:**
```bash
ls -la
```

**Read a text file:**
```bash
cat filename.txt
```

## 8. Stuck?

- Re-read the OSINT materials carefully - the details that seem
  unimportant are often the key
- Not every clue is real - some are decoys
- Try each account's credentials on both the VM login AND the web
  portal login - they are not always the same

Good luck, and have fun learning.

