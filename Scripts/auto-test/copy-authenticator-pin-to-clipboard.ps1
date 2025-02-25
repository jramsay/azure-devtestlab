. .\get-authenticator-pin.ps1

az login --identity --client-id $env:managedIdentityClientId >$null 2>&1
$secretKey = az keyvault secret show --name $env:azurePortalMFASecretKey --vault-name $env:keyvaultName --query value -o tsv
Set-Clipboard -Value (Get-AuthenticatorPin -SecretKey $secretKey)
Write-Output "Authenticator PIN Code was copied to the clipboard."