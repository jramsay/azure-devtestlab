# Get the current PowerShell process ID
$currentPID = $PID

# Get all processes with a window title
$processes = Get-Process | Where-Object { $_.MainWindowTitle -ne "" }

foreach ($process in $processes) {
    # Get the command line details for the process
    $commandLine = (Get-CimInstance Win32_Process -Filter "ProcessId = $($process.Id)").CommandLine

    # Check if the process is PowerShell and was launched with launch-server.ps1 or devtunnel.exe
    if ($process.ProcessName -eq "powershell" -and ($commandLine -match "launch-server.ps1" -or $commandLine -match "devtunnel.exe")) {
        # Skip this process
        continue
    }

    # Check if the process is the current PowerShell instance
    if ($process.Id -eq $currentPID) {
        # Skip this process
        continue
    }

    # Close the process
    Stop-Process -Id $process.Id -Force
}

$shell = New-Object -ComObject "Shell.Application"
$shell.minimizeall()