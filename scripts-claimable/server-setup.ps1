param (
    [string]$setupPath,
    [string]$repoPath,
    [int32]$tunnelPortNumber
)

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
$serverPrelaunch = "$setupPath\server-prelaunch.ps1"
Start-Process powershell -ArgumentList "-File `"$serverPrelaunch`" -repoPath `"$repoPath`""
