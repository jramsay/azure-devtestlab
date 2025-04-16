param (
    [string]$setupPath
)

$filePath = "$setupPath\setup-complete.signal"
while (-not (Test-Path $filePath)) {
    Start-Sleep -Seconds 5
}