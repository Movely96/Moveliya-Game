# Moveliya Game

A beginner-friendly OSINT + web recon learning lab.

## Scenario

A student wants to get their hands on important exam materials
before exam day. The only way in is through the school's internal
system, but credentials are needed first.

Three staff members at GCE (Genie Civil Engineering School) are
your targets:
- Abdelmajid Nassit - Director
- Mehdi Med Ali - Deputy Director
- Jannat Lmilali - Administrative Secretary

## How it works

1. Set up the lab (`docker compose up --build`, or `vm-setup/` on Linux)
2. Dig through `osint-materials/` - treat it like real open-source
   intelligence gathering. Not everything is useful; some details
   are decoys.
3. Use the clues to figure out each account's password
4. Log into the lab VM accounts and look for hidden files
5. Check for common recon files that might reveal hidden paths
6. Use what you found to log into the GCE web portal and retrieve
   the real flag

## Getting started

New to this? Start with `beginner-guide/GUIDE.md` - it covers the
tools and basic terminal/network scanning commands.

### Quick start (Windows / macOS / Linux) - recommended

You do **not** need an Ubuntu VM. The whole lab runs in Docker and
works the same on every OS. Install
[Docker Desktop](https://www.docker.com/products/docker-desktop/),
start it, then from this folder:

```bash
docker compose up --build
```

Windows users can instead just double-click / run `start.ps1`
(right-click > Run with PowerShell). It builds and launches the lab
and opens the browser for you. Stop it with `stop.ps1`.

Once it's up:
- Web portal: http://localhost:8080/gce/home.php
- SSH host:   `ssh <user>@localhost -p 2222` (nmap/hydra target: `localhost -p 2222`)

### Alternative: native Ubuntu/Debian VM

Advanced/offline setups can build the lab directly on a Linux
machine with `vm-setup/setup.sh` (installs Apache/PHP/OpenSSH and
creates the accounts). See `beginner-guide/GUIDE.md`.

## Structure
```
moveliya-game/
├── web/             GCE web portal (PHP) + Dockerfile
├── ssh/             SSH lab host: accounts + hidden files + Dockerfile
├── osint-materials/ Character dossiers for OSINT research
├── vm-setup/        Native Ubuntu/Debian setup script
├── beginner-guide/  Step-by-step guide for total beginners
├── docker-compose.yml
└── start.ps1 / stop.ps1   Windows launchers
```


## Important note for whoever sets up the lab

The answers live in plain text in this repo:
- SSH passwords + hidden portal creds: `ssh/create-users.sh`
- Web portal passwords: `web/gce/config.php`
- The flag: `web/gce/exams.php`

WARNING: **do not give players this repo.** If the repo is public
(or you hand them the folder), anyone can read those files and get
every password and the flag without playing.

For a real challenge, run the lab yourself and give players only
network access to it:
- Build and start it (`docker compose up --build` or `start.ps1`).
- Players interact only with `localhost:8080` and `localhost:2222`
  (or your host's IP) - they never see the source.
- Keep this repo private.

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
