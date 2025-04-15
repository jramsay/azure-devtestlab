param (
    [string]$setupPath,
    [string]$repoPath,
    [int32]$tunnelPortNumber
)

Set-Location -Path $repoPath

$env:UV_HTTP_TIMEOUT=350
$env:Path = "C:\Users\$env:USERNAME\.local\bin;$env:Path"

taskkill /f /im python.exe
uv sync
.venv\Scripts\activate

uv run playwright install

Write-Output "Starting dev tunnel..."
$launchDevTunnel = "$setupPath\launch-devtunnel.ps1"
Start-Process powershell -ArgumentList "-File `"$launchDevTunnel`" -setupPath `"$setupPath`" -portNumber $tunnelPortNumber" -NoNewWindow -PassThru -RedirectStandardOutput "tunnel.txt"

Write-Output "Minimize windows..."
$minimize = "$setupPath\minimize-windows.ps1"
Start-Process powershell -ArgumentList "-File `"$minimize`""

py -m flask --app test_engine.server.server run