. .\get-authenticator-pin.ps1

az login --identity --client-id $env:managedIdentityClientId
$secretKey = az keyvault secret show --name $env:azurePortalMFASecretKey --vault-name $env:keyvaultName --query value -o tsv >$null 2>&1
Set-Clipboard -Value (Get-AuthenticatorPin -SecretKey $secretKey)
Write-Output "Authenticator PIN Code was copied to the clipboard."