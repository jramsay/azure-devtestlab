$url = "https://aka.ms/vs/17/pre/vs_community.exe"
$tempDir = [System.IO.Path]::GetTempPath()
$output = [System.IO.Path]::Combine($tempDir, "vs_community.exe")

$ProgressPreference = 'SilentlyContinue'
Invoke-WebRequest -Uri $url -OutFile $output

Start-Process -FilePath $output -ArgumentList "--passive" -Wait

$vsPath = "C:\Program Files\Microsoft Visual Studio\2022\Preview\Common7\IDE\devenv.exe"
$publicDesktop = [System.Environment]::GetFolderPath("CommonDesktopDirectory")
$shortcutPath = [System.IO.Path]::Combine($publicDesktop, "Visual Studio 2022.lnk")
$wshShell = New-Object -ComObject WScript.Shell
$shortcut = $wshShell.CreateShortcut($shortcutPath)
$shortcut.TargetPath = $vsPath
$shortcut.Save()