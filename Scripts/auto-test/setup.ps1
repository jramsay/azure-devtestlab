param (
    [string]$autoLoginUsername,
    [string]$autoLoginPasswordSecretKey,
    [string]$azurePortalUsernameSecretKey,
    [string]$azurePortalPasswordSecretKey,
    [string]$azurePortalMFASecretKey,
    [string]$keyvaultName,
    [string]$managedIdentityClientId,
    [string]$setupPath = "C:\setup",
    [string]$repoPath = "C:\AI-Incubation\src\AutomatedTests",
    [int32]$tunnelPortNumber = 5000
)

Write-Output "Store KV info to be used by other scripts."
[System.Environment]::SetEnvironmentVariable("autoLoginUsername", $autoLoginUsername, [System.EnvironmentVariableTarget]::Machine)
[System.Environment]::SetEnvironmentVariable("autoLoginPasswordSecretKey", $autoLoginPasswordSecretKey, [System.EnvironmentVariableTarget]::Machine)
[System.Environment]::SetEnvironmentVariable("azurePortalUsernameSecretKey", $azurePortalUsernameSecretKey, [System.EnvironmentVariableTarget]::Machine)
[System.Environment]::SetEnvironmentVariable("azurePortalPasswordSecretKey", $azurePortalPasswordSecretKey, [System.EnvironmentVariableTarget]::Machine)
[System.Environment]::SetEnvironmentVariable("azurePortalMFASecretKey", $azurePortalMFASecretKey, [System.EnvironmentVariableTarget]::Machine)
[System.Environment]::SetEnvironmentVariable("keyvaultName", $keyvaultName, [System.EnvironmentVariableTarget]::Machine)
[System.Environment]::SetEnvironmentVariable("managedIdentityClientId", $managedIdentityClientId, [System.EnvironmentVariableTarget]::Machine)

Write-Output "Copying files to setup directory..."
$sourceDirectory = Get-Location
$destinationDirectory = $setupPath
if (-Not (Test-Path -Path $destinationDirectory)) {
    New-Item -ItemType Directory -Path $destinationDirectory
}
Copy-Item -Path "$sourceDirectory\*" -Destination $destinationDirectory -Recurse
Set-Location -Path $setupPath

Write-Output "Installing Azure CLI.."
$ProgressPreference = 'SilentlyContinue'; Invoke-WebRequest -Uri https://aka.ms/installazurecliwindows -OutFile .\AzureCLI.msi; Start-Process msiexec.exe -Wait -ArgumentList '/I AzureCLI.msi /quiet'; Remove-Item .\AzureCLI.msi

Write-Output "Setting up Windows auto-logon..."
$scriptPath = ".\setup-autologon.ps1"
Start-Process powershell.exe -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$scriptPath`" -autoLoginUsername `"$autoLoginUsername`" -autoLoginPasswordSecretKey `"$autoLoginPasswordSecretKey`" -keyvaultName `"$keyvaultName`" -managedIdentityClientId `"$managedIdentityClientId`"" -Wait

Write-Output "Installing dotnet 8..."
$dotnetInstallerUrl = "https://download.visualstudio.microsoft.com/download/pr/bd44cdb8-dcac-4f1f-8246-1ee392c68dac/ba818a6e513c305d4438c7da45c2b085/dotnet-sdk-8.0.406-win-x64.exe"
$installerPath = "$env:TEMP\dotnet-sdk-8.0.406-win-x64.exe"
Invoke-WebRequest -Uri $dotnetInstallerUrl -OutFile $installerPath
Start-Process -FilePath $installerPath -ArgumentList "/quiet" -NoNewWindow -Wait
Remove-Item -Path $installerPath -Force

Write-Output "Installing dev tunnel..."
Invoke-WebRequest -Uri https://aka.ms/TunnelsCliDownload/win-x64 -OutFile devtunnel.exe

Write-Output "Create a scheduled task to launch the server & tunnel after autologon"
$launchServer = "$setupPath\launch-server-and-tunnel.ps1"
schtasks /create /tn "RunScriptAtLogon" /tr "powershell.exe -File $launchServer -setupPath $setupPath -repoPath $repoPath -tunnelPortNumber $tunnelPortNumber" /sc onlogon /rl highest /f /it /RU $autoLoginUsername

Restart-Computer -Force