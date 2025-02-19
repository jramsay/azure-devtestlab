param (
    [string]$repoPath = "C:\AI-Incubation\src\AutomatedTests"
)

Set-Location -Path $repoPath

$env:UV_HTTP_TIMEOUT="350s"

$env:Path = "C:\Users\$env:USERNAME\.local\bin;$env:Path"
uv sync
.venv\Scripts\activate

py -m flask --app test_engine.server.server run > server-log.txt 2>&1