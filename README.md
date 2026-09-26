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

New to this? Start with `beginner-guide/GUIDE.md` first - it covers
everything you need, including software installation and basic
terminal/network scanning commands. Works whether you're on
Windows, macOS, or Linux.

## Structure
moveliya-game/
├── osint-materials/ Character dossiers for OSINT research
├── vm-setup/ Setup script + images to build the lab
└── beginner-guide/ Step-by-step guide for total beginners


## Important note for whoever sets up the lab

The `vm-setup/setup.sh` script contains all the real passwords in
plain text. After running it inside your VM, delete the cloned
repository folder so players can't just read the script to find
the answers:

```bash
cd ~
rm -rf moveliya-game
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
