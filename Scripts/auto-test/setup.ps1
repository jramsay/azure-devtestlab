param (
    [string]$setupPath = "C:\setup"
)

$sourceDirectory = Get-Location
$destinationDirectory = $setupPath

if (-Not (Test-Path -Path $destinationDirectory)) {
    New-Item -ItemType Directory -Path $destinationDirectory
}

Copy-Item -Path "$sourceDirectory\*" -Destination $destinationDirectory -Recurse

Set-Location -Path $setupPath

Write-Output "Installing python..."
$installPython = "$setupPath\install-python.ps1"
Invoke-Expression -Command $installPython
Write-Output "Python installation completed."

Write-Output "Installing conda..."
$condaScript = "$setupPath\install-conda.ps1"
$condaProcess = Start-Process powershell -ArgumentList "-File `"$condaScript`"" -PassThru
$condaProcess.WaitForExit()
Write-Output "Conda installation completed."

Write-Output "Installing dev tunnel..."
$installDevTunnel = "$setupPath\install-devtunnel.ps1"
Invoke-Expression -Command $installDevTunnel

Write-Output "Launching server and tunnel..."
$launchServer = "$setupPath\launch-server-and-tunnel.ps1"
Invoke-Expression -Command $launchServer