az login --identity --client-id $env:managedIdentityClientId
$password = az keyvault secret show --name $env:autoLoginPasswordSecretKey --vault-name $env:keyvaultName --query value -o tsv
$registryPath = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon"
Set-ItemProperty -Path $registryPath -Name "DefaultUserName" -Value $env:autoLoginUsername
Set-ItemProperty -Path $registryPath -Name "DefaultPassword" -Value $password
Set-ItemProperty -Path $registryPath -Name "AutoAdminLogon" -Value "1"