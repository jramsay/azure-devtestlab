param (
    [string]$autoLoginUsername,
    [string]$autoLoginPasswordSecretKey,
    [string]$keyvaultName,
    [string]$managedIdentityClientId
)

az login --identity --client-id $managedIdentityClientId
$password = az keyvault secret show --name $autoLoginPasswordSecretKey --vault-name $keyvaultName --query value -o tsv
$registryPath = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon"
Set-ItemProperty -Path $registryPath -Name "DefaultUserName" -Value $autoLoginUsername
Set-ItemProperty -Path $registryPath -Name "DefaultPassword" -Value $password
Set-ItemProperty -Path $registryPath -Name "AutoAdminLogon" -Value "1"