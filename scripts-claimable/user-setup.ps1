param (
    [string]$setupPath
)

# Disable OneDrive Windows Backup dialog
$registryPath = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Notifications\Settings\Microsoft.SkyDrive.Desktop"
$propertyName = "Enabled"
$propertyValue = 0
if (-not (Test-Path $registryPath)) {
    New-Item -Path $registryPath -Force
}
Set-ItemProperty -Path $registryPath -Name $propertyName -Value $propertyValue

Write-Output "Creating uxauto.json"
$createUXAuto = "$setupPath\create-uxauto.ps1"
Invoke-Expression -Command $createUXAuto
Write-Output "uxauto.json created."
