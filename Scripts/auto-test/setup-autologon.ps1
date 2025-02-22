param (
    [string]$autoLoginUsernameSecretKey,
    [string]$autoLoginPasswordSecretKey
)

az login --identity --client-id $env:managedIdentityClientId
$username = az keyvault secret show --name $autoLoginUsernameSecretKey --vault-name $env:keyvaultName --query value -o tsv
$password = az keyvault secret show --name $autoLoginPasswordSecretKey --vault-name $env:keyvaultName --query value -o tsv
$registryPath = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon"
Set-ItemProperty -Path $registryPath -Name "DefaultUserName" -Value $username
Set-ItemProperty -Path $registryPath -Name "DefaultPassword" -Value $password
Set-ItemProperty -Path $registryPath -Name "AutoAdminLogon" -Value "1"