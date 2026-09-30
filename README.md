# Moveliya Game

A beginner-friendly OSINT + web recon learning lab.

## Scenario

A student wants to get their hands on important exam materials
before exam day. The only way in is through the school's internal
system, but credentials are needed first.

Three staff members at GCE (Genie Civil Engineering School) are
your targets:
- Abdelmajid Sandal - Director
- Mehdi Med Ali - Deputy Director
- Jannat Lmilali - Administrative Secretary

## How it works

1. Set up the lab (see `vm-setup/`)
2. Dig through `osint-materials/` - treat it like real open-source
   intelligence gathering. Not everything is useful; some details
   are decoys.
3. Use the clues to figure out each account's password
4. Log into the lab VM accounts and look for hidden files
6. Check for common recon files that might reveal hidden paths
7. Use what you found to log into the GCE web portal and retrieve
   the real flag

## Getting started

There are two ways to run the lab. Both give the exact same game
(same accounts, credentials, and flag).

### Option A - Docker (recommended, works on macOS/Windows/Linux)

The whole lab is packaged as two containers, so you don't need a
virtual machine. You only need [Docker Desktop](https://www.docker.com/products/docker-desktop/)
(macOS/Windows) or Docker Engine (Linux).

```bash
git clone <repo-url>
cd moveliya-game
docker compose up --build
```

Then, from your own machine, treat these as the "lab" you're
attacking:

- **Web portal:** http://localhost:8080 (start at
  `http://localhost:8080/gce/home.php`; there's a `robots.txt` at
  `http://localhost:8080/robots.txt`)
- **SSH host:** `localhost` on port `2222` - your `nmap` / `hydra`
  target, and where you `ssh` in once you have a password

When you're done: `docker compose down`.

### Option B - Virtual machine

The original VM path still works. See `beginner-guide/GUIDE.md`
for the full walkthrough (VirtualBox/UTM + `vm-setup/setup.sh`).

## Structure
moveliya-game/
├── osint-materials/ Character dossiers for OSINT research
├── vm-setup/ VM setup script + images (Option B)
├── docker/ Container sources for the web + ssh lab (Option A)
├── docker-compose.yml Brings the whole lab up with one command
└── beginner-guide/ Step-by-step guide for total beginners


## Important note for whoever sets up the lab

Both the `vm-setup/setup.sh` script and the files under `docker/`
contain all the real passwords in plain text (that's how the lab
is built). Whichever option you use, run it somewhere the players
can't read the source, then hand players only the running lab -
not this repository:

```bash
# VM option: after running setup.sh inside the VM
cd ~
rm -rf moveliya-game

# Docker option: build/run on your own machine, then give players
# only the two endpoints (http://localhost:8080 and ssh port 2222),
# not the docker/ folder.
```

## Rules

- This is a self-contained offline lab. No real systems, people,
  or organizations are involved.
- Flag format: `FLAG{...}`

## Disclaimer

This project is for educational purposes only, intended to teach
OSINT and basic web/network reconnaissance concepts in a safe,
isolated environment. Do not use these techniques against real
systems or people without explicit authorization.

Good luck.

Movely also is a beginner so for any recommendations jst contact me 
mounasandalh@gmail.com
