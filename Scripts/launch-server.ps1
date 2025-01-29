$tunnelScript = "C:\setup\start-devtunnel.ps1"
Start-Process powershell -ArgumentList "-NoExit -File `"$tunnelScript`""

# Activate the Conda environment
conda activate uitesting

# Install required Python packages
pip install -r requirements.txt

# Install autogen 
pip install autogen-agentchat==0.2.37

flask --app server run
