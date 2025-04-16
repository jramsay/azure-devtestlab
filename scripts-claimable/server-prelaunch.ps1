param (
    [string]$repoPath
)

Set-Location -Path $repoPath

$env:UV_HTTP_TIMEOUT=350

taskkill /f /im python.exe
uv sync
.venv\Scripts\activate

uv run playwright install