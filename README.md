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
5. Scan the web server and check common recon files (like
   `robots.txt`) to discover where the school's portal lives -
   it is not linked from the server's front page
6. Use the credentials you found to log into the GCE web portal and
   retrieve the real flag

## Getting started

New to this? Start with `beginner-guide/GUIDE.md` - it covers the
tools and basic terminal/network scanning commands.

### Quick start (Windows / macOS / Linux) - recommended

Full step-by-step instructions: **[RUN_WITH_DOCKER.md](RUN_WITH_DOCKER.md)**.

You do **not** need an Ubuntu VM. The whole lab runs in Docker and
works the same on every OS. Install
[Docker Desktop](https://www.docker.com/products/docker-desktop/),
start it, then from this folder:

```bash
docker compose up --build
```

Both ports are bound to `127.0.0.1`, so only your own computer can
reach the lab (it contains deliberately weak passwords).

Windows users can instead just double-click / run `start.ps1`
(right-click > Run with PowerShell). It builds and launches the lab
and opens the browser for you. Stop it with `stop.ps1`.

Once it's up:
- Web server: http://localhost:8080 (the portal is hidden - find it through recon)
- SSH host:   `ssh <user>@localhost -p 2222` (nmap/hydra target: `localhost -p 2222`)

### Alternative: native Ubuntu/Debian VM

Advanced/offline setups can build the lab directly on a Linux
machine with `vm-setup/setup.sh` (installs Apache/PHP/OpenSSH and
creates the accounts). See `beginner-guide/GUIDE.md`.

## Structure
```
Moveliya-Game/
├── web/             GCE web portal (PHP, shared layout in gce/includes/) + Dockerfile
├── ssh/             SSH lab host: accounts + hidden files + Dockerfile
├── osint-materials/ Character dossiers for OSINT research
├── vm-setup/        Native Ubuntu/Debian setup script
├── beginner-guide/  Step-by-step guide for total beginners
├── docker-compose.yml
└── start.ps1 / stop.ps1   Windows launchers
```


## Spoiler warning

This repository contains the source of the lab, which includes parts of the
solution (account setup, portal code). To play the challenge properly, **just
run the lab** and treat it as a black box: do not read the files in `ssh/` or
`web/`. Everything you need is reachable from the running lab and the
`osint-materials/` folder.

Hosting this for other people? Run the lab yourself and let players connect to
it, instead of giving them the source.

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

Feedback and suggestions are welcome - please open a GitHub issue.
