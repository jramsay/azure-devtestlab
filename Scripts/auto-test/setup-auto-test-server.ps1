param (
    [string]$setupPath = "C:\setup"
)

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

Write-Output "Starting dev tunnel..."
$startDevTunnel = "$setupPath\start-devtunnel.ps1"
Start-Process powershell -ArgumentList "-NoExit -File `"$startDevTunnel`""

Write-Output "Launching server..."
$serverScript = "$setupPath\launch-server.ps1"
Start-Process powershell -ArgumentList "-NoExit -File `"$serverScript`""