param (
    [string]$repoPath = "C:\AI-Incubation\src\AutomatedTests"
)

Set-Location -Path $repoPath

uv sync
.venv\Scripts\activate

py -m flask --app server run > server-log.txt 2>&1