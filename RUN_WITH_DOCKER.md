# How to run the lab with Docker

The whole Moveliya lab (the SSH machine and the GCE web server) runs in two
Docker containers. It works the same on Ubuntu/Linux, Windows and macOS, and you
do **not** need a virtual machine.

> The lab contains deliberately weak accounts. Both ports are bound to
> `127.0.0.1`, so only **your own computer** can reach it.

---

## 1. What you need

- About 2 GB of free disk space and an internet connection for the first build
- Docker (installation steps below)
- A terminal

## 2. Install Docker

### Ubuntu / Debian
```bash
sudo apt update
sudo apt install -y docker.io docker-compose-v2
sudo usermod -aG docker $USER
```
Then **log out and log back in** (or restart) so you can run Docker without `sudo`.
Check it works:
```bash
docker --version
docker compose version
```

### Windows
1. Install [Docker Desktop](https://www.docker.com/products/docker-desktop/) and restart if asked.
2. Open Docker Desktop and wait until it says the engine is running.

### macOS
1. Install [Docker Desktop](https://www.docker.com/products/docker-desktop/) (pick the Intel or Apple Silicon version).
2. Open Docker Desktop and wait until the engine is running.

## 3. Start the lab

Open a terminal **inside the project folder** (the one containing `docker-compose.yml`).

```bash
docker compose up --build
```

- The first run takes a few minutes while images are downloaded and built.
- Leave this terminal open. The lab runs as long as it does.
- It is ready when the text stops scrolling and you see
  `Server listening` (SSH) and `resuming normal operations` (web).

Prefer to keep your terminal free? Add `-d` to run it in the background:
```bash
docker compose up --build -d
```

Windows shortcut: right-click `start.ps1` and choose **Run with PowerShell**.

## 4. Where the lab is

| Service    | Address                        |
|------------|--------------------------------|
| Web server | http://localhost:8080          |
| SSH server | `ssh <user>@localhost -p 2222` |

For scanning tools such as nmap or hydra, the target is `localhost` and the SSH
port is `2222`.

Everything else is for you to discover. Start with
`beginner-guide/GUIDE.md` and the files in `osint-materials/`.

## 5. Stop the lab

- If it is running in the foreground: press **Ctrl + C** in that terminal.
- Then remove the containers:
  ```bash
  docker compose down
  ```
- Windows shortcut: `stop.ps1`.

## 6. Start over from scratch

If you changed something or want a completely fresh lab:
```bash
docker compose down
docker compose up --build
```
To also delete the images that were built:
```bash
docker compose down --rmi local
```

## 7. Troubleshooting

| Problem | Fix |
|---------|-----|
| `permission denied ... docker.sock` (Linux) | Run `sudo usermod -aG docker $USER`, then log out and back in. For a quick fix in the current terminal, run `newgrp docker`, or put `sudo` in front of the command. |
| `port is already allocated` / port in use | Another program uses 8080 or 2222. Stop it, or change the left-hand numbers in `docker-compose.yml` (for example `"127.0.0.1:8081:80"`). |
| `Cannot connect to the Docker daemon` (Windows/macOS) | Docker Desktop is not running. Open it and wait for the engine to start. |
| `docker: 'compose' is not a docker command` | Install the compose plugin (`sudo apt install docker-compose-v2` on Ubuntu) or update Docker Desktop. |
| `ssh: connection refused` | The lab is not running, or you forgot `-p 2222`. |
| SSH warns that the host key changed after a rebuild | Run `ssh-keygen -R "[localhost]:2222"` and try again. |
| The browser shows nothing on port 8080 | Run `docker compose ps` to check both containers are up. Use `docker compose logs web` to see errors. |
| Apache prints `AH00558 ... fully qualified domain name` | Harmless warning. Ignore it. |

## 8. Play fair (spoiler warning)

The source code of this repository contains parts of the solution. To get the
real experience, do not read the files in `ssh/` or `web/`: attack the running
lab like a black box, using only the OSINT materials and your tools.

If you are hosting the lab for other people, run it yourself and let them
connect to it instead of handing them the source.
