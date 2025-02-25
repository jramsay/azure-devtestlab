param (
    [string]$repoPath
)

# Create uxauto.json file in the user's profile directory
$uxautoContent = @"
{
    "monitor": 0,
    "enable_safety_agent": false,
    "vstest" : {}
}
"@

$uxautoPath = [System.IO.Path]::Combine($env:USERPROFILE, "uxauto.json")
Set-Content -Path $uxautoPath -Value $uxautoContent