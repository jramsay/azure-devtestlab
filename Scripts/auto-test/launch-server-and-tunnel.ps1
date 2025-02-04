param (
    [string]$setupPath = "C:\setup"
)

Write-Output "Launching server..."
$launchServer = "$setupPath\launch-server.ps1"
Start-Process powershell -ArgumentList "-NoExit -File `"$launchServer`""

Write-Output "Starting dev tunnel..."
$launchDevTunnel = "$setupPath\launch-devtunnel.ps1"
Start-Process powershell -ArgumentList "-File `"$launchDevTunnel`"" -NoNewWindow -PassThru -Wait