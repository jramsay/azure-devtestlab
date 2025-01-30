$sourceDirectory = Get-Location
$destinationDirectory = "C:\setup"

if (-Not (Test-Path -Path $destinationDirectory)) {
    New-Item -ItemType Directory -Path $destinationDirectory
}

Copy-Item -Path "$sourceDirectory\*" -Destination $destinationDirectory -Recurse

# Set-Location -Path "C:\setup"

# $entryPath = "C:\setup\install-python-create-uxauto.ps1"

# Invoke-Expression -Command $entryPath