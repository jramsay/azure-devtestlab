Set-Location -Path "C:\setup"

Write-Output "Installing python..."
$installPython = "C:\setup\install-python.ps1"
Invoke-Expression -Command $installPython
Write-Output "Python installation completed."

Write-Output "Installing conda..."
$condaScript = "C:\setup\install-conda.ps1"
$condaProcess = Start-Process powershell -ArgumentList "-NoExit -File `"$condaScript`"" -PassThru
$condaProcess.WaitForExit()
Write-Output "Conda installation completed."

Write-Output "Starting dev tunnel..."
$startDevTunnel = "C:\setup\start-devtunnel.ps1"
Start-Process powershell -ArgumentList "-NoExit -File `"$startDevTunnel`""
Write-Output "Dev tunnel started."

Write-Output "Launching server..."
$serverScript = "C:\setup\launch-server.ps1"
Start-Process powershell -ArgumentList "-NoExit -File `"$serverScript`""
Write-Output "Server exited"