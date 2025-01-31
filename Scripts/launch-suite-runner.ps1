param (
    [string]$testIds,
    [string]$gitHubToken,
    [string]$issuePath,
    [string]$repoUrl
)

Set-Location -Path "C:\AI-Incubation\src\AutomatedTests"

conda activate uitesting
pip install autogen-agentchat==0.2.37

Write-Output "testIds: $testIds"
Write-Output "gitHubToken: $gitHubToken"
Write-Output "issuePath: $issuePath"
Write-Output "repoUrl: $repoUrl"

python .\suite_runner.py --mode azdo --azdo_tcids $testIds --gh_pat $gitHubToken --gh_issue $issuePath

# python .\suite_runner.py --mode azdo --azdo_tcids $testIds