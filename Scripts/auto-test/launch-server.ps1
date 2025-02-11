param (
    [string]$repoPath = "C:\AI-Incubation\src\AutomatedTests"
)

Set-Location -Path $repoPath

conda activate uitesting

py -m pip install -r requirements.txt

# Temp fix: install specific version of autogen
py -m pip install autogen-agentchat==0.2.37

py -m flask --app server run > server-log.txt 2>&1