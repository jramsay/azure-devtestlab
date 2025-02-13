param (
    [string]$username,
    [string]$password
)

$registryPath = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon"
Set-ItemProperty -Path $registryPath -Name "DefaultUserName" -Value $username
Set-ItemProperty -Path $registryPath -Name "DefaultPassword" -Value $password
Set-ItemProperty -Path $registryPath -Name "AutoAdminLogon" -Value "1"

$action = New-ScheduledTaskAction -Execute 'Powershell.exe' -Argument '-File "C:\setup\setup.ps1"'
$trigger = New-ScheduledTaskTrigger -AtLogon
Register-ScheduledTask -Action $action -Trigger $trigger -TaskName "RunScriptAfterLogon" -Description "Runs setup script after logon"

Restart-Computer -Force
