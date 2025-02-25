# Autonomous Testing Demo Setup

This guide provides instructions to set up the autonomous testing demo using PowerShell scripts in a DevTest Lab Windows environment.

## Prerequisites

1. **DevTest Lab**: Ensure you have access to a DevTest Lab.
2. **Personal Access Token (PAT)**: Generate a PAT to access the [AI-Incubation](https://devdiv.visualstudio.com/DevDiv/_git/AI-Incubation?path=%2Fsrc%2FAutomatedTests) repository.

## Steps

### 1. Clone the Git Repository

Create a "Clone a git repository" artifact in your DevTest Lab vm or formula with the following settings:

- **Git Repo URI**: `https://devdiv.visualstudio.com/DefaultCollection/DevDiv/_git/AI-Incubation`
- **Destination**: `C:\`
- **Branch / Tag**: `main`
- **Personal Access Token**: `<insert PAT to access that repository>`

### 2. Deploy Scripts to DevTest Lab VM

Deploy the scripts in this directory to a DevTest Lab VM using a "Run Powershell" artifact. Use the following settings:

- **File URI(s)**:
  
  ["https://dev.azure.com/devdiv/OnlineServices/_apis/git/repositories/ux-test-agent/items?path=/scripts/auto-test/copy-authenticator-pin-to-clipboard.ps1&versionDescriptor.version=main&$format=octetStream","https://dev.azure.com/devdiv/OnlineServices/_apis/git/repositories/ux-test-agent/items?path=/scripts/auto-test/copy-password-to-clipboard.ps1&versionDescriptor.version=main&$format=octetStream","https://dev.azure.com/devdiv/OnlineServices/_apis/git/repositories/ux-test-agent/items?path=/scripts/auto-test/create-uxauto.ps1&versionDescriptor.version=main&$format=octetStream","https://dev.azure.com/devdiv/OnlineServices/_apis/git/repositories/ux-test-agent/items?path=/scripts/auto-test/disconnect.ps1&versionDescriptor.version=main&$format=octetStream","https://dev.azure.com/devdiv/OnlineServices/_apis/git/repositories/ux-test-agent/items?path=/scripts/auto-test/get-authenticator-pin.ps1&versionDescriptor.version=main&$format=octetStream","https://dev.azure.com/devdiv/OnlineServices/_apis/git/repositories/ux-test-agent/items?path=/scripts/auto-test/install-python.ps1&versionDescriptor.version=main&$format=octetStream","https://dev.azure.com/devdiv/OnlineServices/_apis/git/repositories/ux-test-agent/items?path=/scripts/auto-test/launch-devtunnel.ps1&versionDescriptor.version=main&$format=octetStream","https://dev.azure.com/devdiv/OnlineServices/_apis/git/repositories/ux-test-agent/items?path=/scripts/auto-test/launch-server-and-tunnel.ps1&versionDescriptor.version=main&$format=octetStream","https://dev.azure.com/devdiv/OnlineServices/_apis/git/repositories/ux-test-agent/items?path=/scripts/auto-test/launch-server.ps1&versionDescriptor.version=main&$format=octetStream","https://dev.azure.com/devdiv/OnlineServices/_apis/git/repositories/ux-test-agent/items?path=/scripts/auto-test/launch-suite-runner.ps1&versionDescriptor.version=main&$format=octetStream","https://dev.azure.com/devdiv/OnlineServices/_apis/git/repositories/ux-test-agent/items?path=/scripts/auto-test/minimize-windows.ps1&versionDescriptor.version=main&$format=octetStream","https://dev.azure.com/devdiv/OnlineServices/_apis/git/repositories/ux-test-agent/items?path=/scripts/auto-test/setup-autologon.ps1&versionDescriptor.version=main&$format=octetStream","https://dev.azure.com/devdiv/OnlineServices/_apis/git/repositories/ux-test-agent/items?path=/scripts/auto-test/setup.ps1&versionDescriptor.version=main&$format=octetStream"]

- **Script to Run**: `./setup.ps1`

- **Script Arguments**:
    - [string]$autoLoginUsername,
    - [string]$autoLoginPasswordSecretKey,
    - [string]$azurePortalUsernameSecretKey,
    - [string]$azurePortalPasswordSecretKey,
    - [string]$azurePortalMFASecretKey,
    - [string]$keyvaultName,
    - [string]$managedIdentityClientId,
    - [string]$setupPath = "C:\setup",
    - [string]$repoPath = "C:\AI-Incubation\src\AutomatedTests",
    - [int32]$tunnelPortNumber = 5000

    [example]
    jasonra auto-test-password auto-test-azure-portal-username auto-test-azure-portal-password auto-test-azure-portal-MFA jasonraautonomo78ed8451 8286efbb-1b94-4821-8876-b87156372c08
