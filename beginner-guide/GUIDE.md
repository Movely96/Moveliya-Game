# Beginner's Guide

Never used a virtual machine or a terminal before? Start here.

## Two ways to run this lab

- **Easy (recommended, any OS incl. Windows): Docker.** No VM, no
  Ubuntu install. See "Easy way" just below.
- **Advanced: a full Ubuntu VM.** More setup, but a real desktop
  Linux to explore. That's sections 1-8 further down.

Either way, once the lab is running the OSINT/cracking steps
(cupp, nmap, hydra, ssh) are the same.

## Easy way: Docker (Windows / macOS / Linux)

1. Install [Docker Desktop](https://www.docker.com/products/docker-desktop/)
   and start it.
2. Download this repo (green "Code" button > Download ZIP, then
   unzip) or `git clone` it, and open a terminal in the folder.
3. Start the lab:
   ```bash
   docker compose up --build
   ```
   On Windows you can instead right-click `start.ps1` > Run with
   PowerShell (it launches everything and opens the browser).
4. The lab is now reachable from your normal computer:
   - Web portal: http://localhost:8080/gce/home.php
   - SSH host:   `ssh <user>@localhost -p 2222`
     (nmap/hydra target: `localhost -p 2222`)
5. Install the OSINT tools (nmap, hydra, cupp) either on your host
   or in any small Linux shell, and jump to section 6 below.
6. When you're done: `docker compose down` (or `stop.ps1`).

The rest of this guide (sections 1-5) is only for the full Ubuntu
VM route. Skip it if you used Docker.

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
**cupp** - generates smart password guesses from real facts about a
person (name, birth year, pet name, etc.) instead of guessing
randomly. This is the core OSINT technique this lab is built around.

```bash
sudo apt install cupp -y
cupp -i
```

It will ask you a series of questions about the target (first name,
birth year, nickname, pet name, and so on). Answer using what you
learned from the OSINT materials. It then saves a custom wordlist
file (named after the first name you entered) full of likely
password combinations.

You can then feed that wordlist into hydra to test it against the
VM SSH accounts:

```bash
hydra -l username -P generated_wordlist.txt ssh://localhost
```

Note: only the SSH accounts are meant to be cracked this way. The
web portal passwords are long and random - you will not guess them
with a wordlist. Once you are inside an account over SSH, look for
hidden files (`ls -la`); the portal credentials are stored there.
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
- The SSH password and the web portal password for the same person
  are different - the portal one is hidden inside the account, not
  guessed
- Not every account leads to the flag - the exam materials belong to
  whoever handles exam administration

Good luck, and have fun learning.

