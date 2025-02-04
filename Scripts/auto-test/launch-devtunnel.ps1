param (
    [string]$devTunnelPath = "C:\setup\devtunnel.exe",
    [string]$managedIdentity = "8286efbb-1b94-4821-8876-b87156372c08",
    [int32]$portNumber= 5000
)

# Login to devtunnel
$output = & "$devTunnelPath" login --mi-client-id $managedIdentity
Write-Output $output

# Create a new tunnel
$output = & "$devTunnelPath" create -a 2>&1
Write-Output $output

$exit_status = $LASTEXITCODE
if ($exit_status -ne 0) {
    Write-Output "Create tunnel failed: $output"
} else {
    Write-Output "Create tunnel succeeded"

    $regex = [regex]::Match($output, "Tunnel ID\s*:\s*(\S+)")
    $tunnel_Id = $regex.Groups[1].Value
    if ($tunnel_Id) {
        Write-Output "Tunnel ID: $tunnel_Id"

        # Create a new port
        $output = & "$devTunnelPath" port create -p $portNumber 2>&1
        $exit_status = $LASTEXITCODE
        if ($exit_status -ne 0) {
            Write-Output "Create port failed: $output"
        } else {
            Write-Output "Create port succeeded"
	    $regex = [regex]::Match($output, "Port Number\s*:\s*(\d+)")
            $port_number = $regex.Groups[1].Value
            if ($port_number) {
                Write-Output "Port Number: $port_number"

                # Host the dev tunnel
                Start-Process powershell -ArgumentList "-NoExit -Command `"$devTunnelPath host`""
                Write-Output "Connection Uri: https://$tunnel_id.devtunnels.ms:$port_number"
            } else {
                Write-Output "Failed to extract Port Number from output: $output"
            }
        }
    } else {
        Write-Output "Failed to extract Tunnel ID from output: $output"
    }
}