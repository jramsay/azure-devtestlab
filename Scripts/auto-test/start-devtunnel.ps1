# Install DevTunnels silently
Invoke-WebRequest -Uri https://aka.ms/TunnelsCliDownload/win-x64 -OutFile devtunnel.exe

.\devtunnel.exe login --mi-client-id 8286efbb-1b94-4821-8876-b87156372c08
.\devtunnel.exe host -p 5000 -a
