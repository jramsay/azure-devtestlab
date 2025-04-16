param (
    [string]$setupPath,
    [string]$repoPath,
    [int32]$tunnelPortNumber
)

Set-Location -Path $repoPath

taskkill /f /im python.exe
.venv\Scripts\activate

Write-Output "Starting dev tunnel..."
$launchDevTunnel = "$setupPath\launch-devtunnel.ps1"
Start-Process powershell -ArgumentList "-File `"$launchDevTunnel`" -setupPath `"$setupPath`" -portNumber $tunnelPortNumber" -NoNewWindow -PassThru -RedirectStandardOutput "tunnel.txt"

Write-Output "Minimize windows..."
$minimize = "$setupPath\minimize-windows.ps1"
Start-Process powershell -ArgumentList "-File `"$minimize`""

uv run flask --app test_engine.server.server run