

# Get the https://vsdrop.microsoft.com redirect URL from aka.ms URL
function Get-RedirectURL([string] $URL) 
{
    $request = [System.Net.WebRequest]::Create($URL)
    $request.Method = "HEAD"
    $request.AllowAutoRedirect = $false

    $response = $request.GetResponse()
    $redirectURL = $response.GetResponseHeader("Location")

    return $redirectURL
}

function Get-VSDropAccessToken
{
    try 
    {
        $retryCount = 0
        $maxRetry = 5

        while($true)
        {
            try 
            {
                $endpointURL = 'http://169.254.169.254/metadata/identity/oauth2/token?api-version=2018-02-01&resource=https://microsoft.onmicrosoft.com/c7d9c532-1caa-435b-b505-59ee3c539f04&client_id=8286efbb-1b94-4821-8876-b87156372c08'
                $response = Invoke-WebRequest -Uri $endpointURL -Headers @{ Metadata = "true" } -UseBasicParsing
                $content = $response.Content | ConvertFrom-Json
                return $content.access_token
            }
            catch
            {
                if ($retryCount -ge $maxRetry)
                {
                    throw
                }

                Start-Sleep -Seconds 30
            }

            $retryCount++
        }
    }
    catch
    {
        throw "Failed to obtain an access token from the VSDrop Managed Identity."
    }
}



$akaMSURL = "https://aka.ms/vs/17/pre/candidate/vs_enterprise.exe"
$redirectedURL = Get-RedirectURL -URL $akaMSURL
$vsdropAccessToken = Get-VSDropAccessToken
$headers = @{ Authorization = "Bearer $vsdropAccessToken" }
$filePath = "vs_install.exe"
Invoke-WebRequest -Uri $redirectedURL -Headers $headers -UseBasicParsing -OutFile $filePath 

Start-Process -FilePath $filePath -ArgumentList "--add Microsoft.VisualStudio.Workload.NativeDesktop --add Microsoft.VisualStudio.Workload.NativeCrossPlat --add Microsoft.VisualStudio.Workload.ManagedDesktop --includeRecommended --includeOptional --passive" -Wait

$vsPath = "C:\Program Files\Microsoft Visual Studio\2022\Preview\Common7\IDE\devenv.exe"
$publicDesktop = [System.Environment]::GetFolderPath("CommonDesktopDirectory")
$shortcutPath = [System.IO.Path]::Combine($publicDesktop, "Visual Studio 2022.lnk")
$wshShell = New-Object -ComObject WScript.Shell
$shortcut = $wshShell.CreateShortcut($shortcutPath)
$shortcut.TargetPath = $vsPath
$shortcut.Save()