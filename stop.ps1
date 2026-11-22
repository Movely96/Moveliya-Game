# Moveliya Game - stop the lab (Windows PowerShell).
$ErrorActionPreference = "Stop"
Set-Location -Path $PSScriptRoot
docker compose down
Write-Host "Lab stopped." -ForegroundColor Green
