param (
    [string]$secretValue
)

# Git clone https://github.com/GregoireLD/Powershell-AuthGenerator.git

Import-Module "C:\Powershell-AuthGenerator\Powershell-AuthGenerator.psm1"
$secretCode = Get-AuthenticatorPin -Secret $secretValue
Set-Clipboard -Value  ($secretCode.PINCode -replace ' ', '')