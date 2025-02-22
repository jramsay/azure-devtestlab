az login --identity --client-id $env:managedIdentityClientId
$username = az keyvault secret show --name $env:azurePortalUsernameSecretKey --vault-name $env:keyvaultName --query value -o tsv
az keyvault secret show --name $env:azurePortalPasswordSecretKey --vault-name $env:keyvaultName --query value -o tsv | clip
Write-Output "Azure Portal password for $username was copied to the clipboard."