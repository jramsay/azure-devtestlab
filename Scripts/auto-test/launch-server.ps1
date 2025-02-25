param (
    [string]$repoPath
)

Set-Location -Path $repoPath

$env:UV_HTTP_TIMEOUT=350
$env:Path = "C:\Users\$env:USERNAME\.local\bin;$env:Path"

taskkill /f /im python.exe
uv sync
.venv\Scripts\activate

py -m flask --app test_engine.server.server run