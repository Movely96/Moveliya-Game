# Moveliya Game - Windows launcher (PowerShell).
# Right-click > "Run with PowerShell", or run:  ./start.ps1
# Requires Docker Desktop for Windows (https://www.docker.com/products/docker-desktop/).

$ErrorActionPreference = "Stop"
Set-Location -Path $PSScriptRoot

if (-not (Get-Command docker -ErrorAction SilentlyContinue)) {
    Write-Host "Docker was not found." -ForegroundColor Red
    Write-Host "Install Docker Desktop for Windows, start it, then run this script again:"
    Write-Host "  https://www.docker.com/products/docker-desktop/"
    Read-Host "Press Enter to exit"
    exit 1
}

Write-Host "[*] Building and starting the Moveliya lab (first run downloads base images)..." -ForegroundColor Cyan
docker compose up --build -d

Write-Host ""
Write-Host "Lab is running:" -ForegroundColor Green
Write-Host "  Web portal : http://localhost:8080/gce/home.php"
Write-Host "  SSH host   : ssh <user>@localhost -p 2222   (nmap/hydra: localhost -p 2222)"
Write-Host ""
Write-Host "To stop the lab later:  ./stop.ps1   (or: docker compose down)"

Start-Process "http://localhost:8080/gce/home.php"
