param (
    [string]$setupPath = "C:\setup"
)

Set-Location -Path $setupPath

Unregister-ScheduledTask -TaskName "RunScriptAfterLogon" -Confirm:$false

Write-Output "Installing python..."
$installPython = "$setupPath\install-python.ps1"
Invoke-Expression -Command $installPython
Write-Output "Python installation completed."

Write-Output "Installing uv..."
powershell -ExecutionPolicy ByPass -c "irm https://astral.sh/uv/install.ps1 | iex"
$env:Path = "C:\Users\$env:USERNAME\.local\bin;$env:Path"
Write-Output "UV installation completed."

Write-Output "Installing dev tunnel..."
Invoke-WebRequest -Uri https://aka.ms/TunnelsCliDownload/win-x64 -OutFile devtunnel.exe

Write-Output "Launching server and tunnel..."
$launchServer = "$setupPath\launch-server-and-tunnel.ps1"
Invoke-Expression -Command $launchServer