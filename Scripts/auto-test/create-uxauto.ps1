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