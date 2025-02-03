param (
    [string]$repoPath = "C:\AI-Incubation\src\AutomatedTests"
)

Set-Location -Path $repoPath

conda activate uitesting

pip install -r requirements.txt

# Temp fix: install specific version of autogen
pip install autogen-agentchat==0.2.37

flask --app server run