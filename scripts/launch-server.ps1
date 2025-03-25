param (
    [string]$setupPath,
    [string]$repoPath,
    [int32]$tunnelPortNumber
)

Set-Location -Path $repoPath

$env:UV_HTTP_TIMEOUT=350
$env:Path = "C:\Users\$env:USERNAME\.local\bin;$env:Path"

uv run playwright install

taskkill /f /im python.exe
uv sync
.venv\Scripts\activate

Write-Output "Starting dev tunnel..."
$launchDevTunnel = "$setupPath\launch-devtunnel.ps1"
Start-Process powershell -ArgumentList "-File `"$launchDevTunnel`" -setupPath `"$setupPath`" -portNumber $tunnelPortNumber" -NoNewWindow -PassThru -RedirectStandardOutput "tunnel.txt"

py -m flask --app test_engine.server.server run