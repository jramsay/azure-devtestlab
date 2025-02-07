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
  - `https://<path-to-raw-content>/setup.ps1`
  - `https://raw.githubusercontent.com/jramsay/azure-devtestlab/refs/heads/dev/jasonra/after-demo/Scripts/auto-test/create-uxauto.ps1`
  - `https://raw.githubusercontent.com/jramsay/azure-devtestlab/refs/heads/dev/jasonra/after-demo/Scripts/auto-test/install-devtunnel.ps1`
  - `https://raw.githubusercontent.com/jramsay/azure-devtestlab/refs/heads/dev/jasonra/after-demo/Scripts/auto-test/install-conda.ps1`
  - `https://raw.githubusercontent.com/jramsay/azure-devtestlab/refs/heads/dev/jasonra/after-demo/Scripts/auto-test/install-python.ps1`
  - `https://raw.githubusercontent.com/jramsay/azure-devtestlab/refs/heads/dev/jasonra/after-demo/Scripts/auto-test/launch-devtunnel.ps1`
  - `https://raw.githubusercontent.com/jramsay/azure-devtestlab/refs/heads/dev/jasonra/after-demo/Scripts/auto-test/launch-server-and-tunnel.ps1`
  - `https://raw.githubusercontent.com/jramsay/azure-devtestlab/refs/heads/dev/jasonra/after-demo/Scripts/auto-test/launch-server.ps1`
  - `https://raw.githubusercontent.com/jramsay/azure-devtestlab/refs/heads/dev/jasonra/after-demo/Scripts/auto-test/launch-suite-runner.ps1`

- **Script to Run**: `./setup.ps1`

