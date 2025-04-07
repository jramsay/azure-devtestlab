param (
    [string]$setupPath,
    [string]$repoPath,
    [int32]$tunnelPortNumber
)

Set-Location -Path $setupPath

Write-Output "Reset TunnelInfo"
[System.Environment]::SetEnvironmentVariable("TunnelInfo", "", "Machine")

Write-Output "Close all Powershell and Devtunnel windows..."
Get-Process -Name "Powershell", "DevTunnel" | Where-Object { $_.ID -ne $PID } | Stop-Process -Force

Write-Output "Launching server..."
$launchServer = "$setupPath\launch-server.ps1"
Start-Process powershell -ArgumentList "-NoExit -File `"$launchServer`" -setupPath `"$setupPath`" -repoPath `"$repoPath`" -tunnelPortNumber `"$tunnelPortNumber`""

Write-Output "Minimize windows..."
$minimize = "$setupPath\minimize-windows.ps1"
Invoke-Expression -Command $minimize
