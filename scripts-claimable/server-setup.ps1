param (
    [string]$autoLoginUsername,
    [string]$setupPath,
    [string]$repoPath,
    [int32]$tunnelPortNumber
)

# Disable OneDrive Windows Backup dialog
$registryPath = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Notifications\Settings\Microsoft.SkyDrive.Desktop"
$propertyName = "Enabled"
$propertyValue = 0
if (-not (Test-Path $registryPath)) {
    New-Item -Path $registryPath -Force
}
Set-ItemProperty -Path $registryPath -Name $propertyName -Value $propertyValue

Write-Output "Creating uxauto.json"
$createUXAuto = "$setupPath\create-uxauto.ps1"
Invoke-Expression -Command $createUXAuto
Write-Output "uxauto.json created."

Write-Output "Build Automation Tree Provider"
$AUTOMATION_TREE_PROJECT_PATH = Join-Path -Path $repoPath -ChildPath "AutomationTreeProvider\AutomationTreeProvider"
Start-Process -FilePath "dotnet" -ArgumentList "build", $AUTOMATION_TREE_PROJECT_PATH -NoNewWindow -Wait

Set-Location -Path $setupPath

Write-Output "Installing python..."
$installPython = "$setupPath\install-python.ps1"
Invoke-Expression -Command $installPython
Write-Output "Python installation completed."

Write-Output "Installing uv..."
$env:UV_INSTALL_DIR="C:\Program Files\uv"
powershell -ExecutionPolicy ByPass -c "irm https://astral.sh/uv/install.ps1 | iex"
Write-Output "UV installation completed."
$env:Path = "C:\Program Files\uv;$env:Path"

Set-ExecutionPolicy RemoteSigned -Scope LocalMachine
[Environment]::SetEnvironmentVariable("Path", $env:Path + ";C:\Program Files\Python312", "Machine")
$env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine")

Write-Output "Complete server prelaunch tasks"
Set-Location -Path $repoPath
$env:UV_HTTP_TIMEOUT=350
uv sync
.venv\Scripts\activate
uv run playwright install

Write-Output "Create a scheduled task to start server"
schtasks /delete /tn "RunSetupScriptAtLogon" /f
$resetServer = "$setupPath\reset-server.ps1"
schtasks /create /tn "RunStartServerAtLogon" /tr "powershell.exe -File $resetServer -setupPath $setupPath -repoPath $repoPath -tunnelPortNumber $tunnelPortNumber" /sc onlogon /rl highest /f /it /RU $autoLoginUsername

Write-Output "Signal that user setup is complete"
$filePath = "$setupPath\setup-complete.signal"
New-Item -Path $filePath -ItemType File -Force