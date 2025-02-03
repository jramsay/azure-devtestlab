# Install Python
$pythonUrl = "https://www.python.org/ftp/python/3.12.7/python-3.12.7-amd64.exe"
$destination = "$env:TEMP\\python_installer.exe"

Invoke-WebRequest -Uri $pythonUrl -OutFile $destination

Start-Process -FilePath $destination -ArgumentList "/quiet InstallAllUsers=1 PrependPath=1" -Wait

Set-ExecutionPolicy RemoteSigned -Scope LocalMachine
[Environment]::SetEnvironmentVariable("Path", $env:Path + ";C:\Program Files\Python312", "Machine")

# Refresh the environment variables in the current session
$env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine")