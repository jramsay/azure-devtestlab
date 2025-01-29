# Install Miniconda

$condaUrl = "https://repo.anaconda.com/miniconda/Miniconda3-py312_24.11.1-0-Windows-x86_64.exe"
$destination = "$env:TEMP\\miniconda.exe"

Invoke-WebRequest -Uri $condaUrl -OutFile $destination

Start-Process -FilePath $destination -ArgumentList "/S /InstallationType=AllUsers /AddToPath=1 /RegisterPython=0" -Wait

Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
[Environment]::SetEnvironmentVariable("Path", $env:Path + ";C:\ProgramData\miniconda3\condabin", "User")

# Refresh the environment variables in the current session
$env:Path = [System.Environment]::GetEnvironmentVariable("Path", "User")

# Verify installation
conda --version

# Change directory to the AutomatedTests folder
cd C:\AI-Incubation\src\AutomatedTests

# Create a new Conda environment
conda create -n uitesting python=3.12 -y

conda init

# # open a new window before launching server
# $serverScript = "C:\setup\launch-server.ps1"
# Start-Process powershell -ArgumentList "-NoExit -File `"$serverScript`""
