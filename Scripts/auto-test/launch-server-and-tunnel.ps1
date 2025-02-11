param (
    [string]$setupPath = "C:\setup"
)

Set-Location -Path $setupPath

Set-ExecutionPolicy RemoteSigned -Scope LocalMachine
[Environment]::SetEnvironmentVariable("Path", $env:Path + ";C:\Program Files\Python312", "Machine")

$env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine")

Write-Output "Launching server..."
$launchServer = "$setupPath\launch-server.ps1"
Start-Process powershell -ArgumentList "-NoExit -File `"$launchServer`""

Write-Output "Starting dev tunnel..."
$launchDevTunnel = "$setupPath\launch-devtunnel.ps1"
Start-Process powershell -ArgumentList "-File `"$launchDevTunnel`"" -NoNewWindow -PassThru -RedirectStandardOutput "output.txt"

$uriPattern = "https://([a-zA-Z0-9-]+)\.([a-zA-Z0-9-]+)\.devtunnels\.ms:\d+"

while ($true) {
    if (Test-Path "output.txt") {
        $lines = Get-Content "output.txt"
        foreach ($line in $lines) {
            $regex = [regex]::Match($line, $uriPattern)
            $uri = $regex.Groups[0].Value
            if ($uri) {
                Write-Output "$uri"
                break 2
            }
        }
    }
    Start-Sleep -Seconds 1
}

[System.Environment]::SetEnvironmentVariable("DEV_TUNNEL_URI", $uri, [System.EnvironmentVariableTarget]::Machine)
Write-Output $uri