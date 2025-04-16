# use this script when disconnecting from the DTL VM to ensure screenshots can still be captured

Invoke-Expression -Command ".\minimize-windows.ps1"
$currentSessionId = (query user | Select-String $env:USERNAME).ToString().Split(" ", [System.StringSplitOptions]::RemoveEmptyEntries)[2]
tscon $currentSessionId /dest:console