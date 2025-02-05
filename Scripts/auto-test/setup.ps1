param (
    [string]$setupPath = "C:\setup"
)

$sourceDirectory = Get-Location
$destinationDirectory = $setupPath

if (-Not (Test-Path -Path $destinationDirectory)) {
    New-Item -ItemType Directory -Path $destinationDirectory
}

Copy-Item -Path "$sourceDirectory\*" -Destination $destinationDirectory -Recurse

Write-Output "Set up server..."
$setupServer = "$setupPath\setup-auto-test-server.ps1"
Invoke-Expression -Command $setupServer