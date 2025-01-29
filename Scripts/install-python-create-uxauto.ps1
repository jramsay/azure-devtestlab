# Change directory to C:\
cd C:\

#Clone the repository
# git clone https://$token@devdiv.visualstudio.com/DefaultCollection/DevDiv/_git/AI-Incubation

# Install Python
$pythonUrl = "https://www.python.org/ftp/python/3.12.7/python-3.12.7-amd64.exe"
$destination = "$env:TEMP\\python_installer.exe"

Invoke-WebRequest -Uri $pythonUrl -OutFile $destination

Start-Process -FilePath $destination -ArgumentList "/quiet InstallAllUsers=1 PrependPath=1" -Wait

Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
[Environment]::SetEnvironmentVariable("Path", $env:Path + ";C:\Program Files\Python312", "User")

# Refresh the environment variables in the current session
$env:Path = [System.Environment]::GetEnvironmentVariable("Path", "User")

# Create uxauto.json file in the user's profile directory
$uxautoContent = @'
{
    // To find the monitor number, run the server and navigate to http://localhost:5000/monitor_info
    // Leave this unset to use the primary monitor (which is not necessarily monitor 0)
    //"monitor": 0,
    "vstest": {
        "condaPath": "C:\\ProgramData\\miniconda3\\condabin\\conda.bat",
        "condaEnv": "uitesting",
        "scriptPath": "C:\\AI-Incubation\\src\\AutomatedTests\\agent_runner.py"
    }
}
'@

$uxautoPath = [System.IO.Path]::Combine($env:USERPROFILE, "uxauto.json")
Set-Content -Path $uxautoPath -Value $uxautoContent

# open a new window before installing conda
$condaScript = "C:\setup\install-conda.ps1"
Start-Process powershell -ArgumentList "-NoExit -File `"$condaScript`""