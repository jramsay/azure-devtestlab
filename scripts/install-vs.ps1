$url = "https://aka.ms/vs/17/pre/vs_community.exe"
$tempDir = [System.IO.Path]::GetTempPath()
$output = [System.IO.Path]::Combine($tempDir, "vs_community.exe")

$ProgressPreference = 'SilentlyContinue'
Invoke-WebRequest -Uri $url -OutFile $output

Start-Process -FilePath $output -ArgumentList "--all --passive" -Wait