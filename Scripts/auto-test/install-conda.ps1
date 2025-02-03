param (
    [string]$repoPath = "C:\AI-Incubation\src\AutomatedTests"
)

$condaUrl = "https://repo.anaconda.com/miniconda/Miniconda3-py312_24.11.1-0-Windows-x86_64.exe"
$destination = "$env:TEMP\\miniconda.exe"

Invoke-WebRequest -Uri $condaUrl -OutFile $destination

Start-Process -FilePath $destination -ArgumentList "/S /InstallationType=AllUsers /AddToPath=1 /RegisterPython=0" -Wait

Set-ExecutionPolicy RemoteSigned -Scope LocalMachine
[Environment]::SetEnvironmentVariable("Path", $env:Path + ";C:\ProgramData\miniconda3\condabin", "Machine")

$env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine")

conda --version

Set-Location -Path $repoPath

conda create -n uitesting python=3.12 -y

conda init