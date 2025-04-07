param (
    [string]$setupPath,
    [string]$repoPath,
    [int32]$tunnelPortNumber
)

Set-Location -Path $setupPath

Write-Output "Creating uxauto.json"
$createUXAuto = "$setupPath\create-uxauto.ps1"
Invoke-Expression -Command $createUXAuto
Write-Output "uxauto.json created."

Write-Output "Installing python..."
$installPython = "$setupPath\install-python.ps1"
Invoke-Expression -Command $installPython
Write-Output "Python installation completed."

Write-Output "Installing uv..."
powershell -ExecutionPolicy ByPass -c "irm https://astral.sh/uv/install.ps1 | iex"
Write-Output "UV installation completed."

Set-ExecutionPolicy RemoteSigned -Scope LocalMachine
[Environment]::SetEnvironmentVariable("Path", $env:Path + ";C:\Program Files\Python312", "Machine")
$env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine")

Write-Output "Launching server and tunnel..."
$launchServer = "$setupPath\launch-server-and-tunnel.ps1"
Start-Process powershell -ArgumentList "-File `"$launchServer`" -setupPath `"$setupPath`" -repoPath `"$repoPath`" -tunnelPortNumber `"$tunnelPortNumber`""
