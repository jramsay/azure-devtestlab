Set-Location -Path "C:\AI-Incubation\src\AutomatedTests"

# Activate the Conda environment
conda activate uitesting

# Install required Python packages
pip install -r requirements.txt

# Install autogen 
pip install autogen-agentchat==0.2.37

flask --app server run
