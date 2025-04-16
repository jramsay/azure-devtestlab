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