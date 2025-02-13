param (
    [string]$setupPath = "C:\setup"
)

Set-Location -Path $setupPath

Set-ExecutionPolicy RemoteSigned -Scope LocalMachine
[Environment]::SetEnvironmentVariable("Path", $env:Path + ";C:\Program Files\Python312", "Machine")
$env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine")

Write-Output "Launching server..."
$launchServer = "$setupPath\launch-server.ps1"
Start-Process powershell -ArgumentList "-NoExit -File `"$launchServer`""

Write-Output "Starting dev tunnel..."
$launchDevTunnel = "$setupPath\launch-devtunnel.ps1"
Start-Process powershell -ArgumentList "-File `"$launchDevTunnel`"" -NoNewWindow -PassThru -RedirectStandardOutput "tunnel.txt"

Write-Output "Minimize windows..."
$minimize = "$setupPath\minimize-windows.ps1"
Invoke-Expression -Command $minimize