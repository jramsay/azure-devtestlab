param (
    [string]$autoLoginUsername,
    [string]$autoLoginPasswordSecretKey,
    [string]$keyvaultName,
    [string]$managedIdentityClientId
)

Write-Output "Running az login..."
az login --identity --client-id $managedIdentityClientId 2>&1

Write-Output "Retrieving secret from Key Vault..."
$password = az keyvault secret show --name $autoLoginPasswordSecretKey --vault-name $keyvaultName --query value -o tsv 2>&1

$registryPath = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon"
Set-ItemProperty -Path $registryPath -Name "DefaultUserName" -Value $autoLoginUsername
Set-ItemProperty -Path $registryPath -Name "DefaultPassword" -Value $password
Set-ItemProperty -Path $registryPath -Name "AutoAdminLogon" -Value "1"

# Suppress First-Time Experience for Microsoft Edge
$edgeRegistryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Edge"
New-Item -Path $edgeRegistryPath -Force
New-ItemProperty -Path $edgeRegistryPath -Name "HideFirstRunExperience" -Value 1 -PropertyType DWORD -Force

# Suppress First-Time Experience for Windows
$privacyPoliciesRegistryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\OOBE"
$disablePrivacy = "DisablePrivacyExperience"

# Create or update the registry values
if (-not (Test-Path $privacyPoliciesRegistryPath)) {
    New-Item -Path $privacyPoliciesRegistryPath -Force
}
New-ItemProperty -Path $privacyPoliciesRegistryPath -Name $disablePrivacy -Value 1 -PropertyType DWord -Force