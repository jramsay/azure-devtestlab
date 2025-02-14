param (
    [string]$username,
    [string]$password,
    [string]$setupPath = "C:\setup"
)


$registryPath = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon"
Set-ItemProperty -Path $registryPath -Name "DefaultUserName" -Value $username
Set-ItemProperty -Path $registryPath -Name "DefaultPassword" -Value $password
Set-ItemProperty -Path $registryPath -Name "AutoAdminLogon" -Value "1"

Set-Location -Path $setupPath

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

# Create a scheduled task to launch the server & tunnel at startup after autologon
$launchServer = "$setupPath\launch-server-and-tunnel.ps1"
schtasks /create /tn "RunScriptAtStartup" /tr "powershell.exe -File $launchServer" /sc onstart /rl highest /f

Restart-Computer -Force