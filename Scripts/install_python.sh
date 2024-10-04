#!/bin/bash

# Set up Python
echo "Setting up Python $PYTHON_VERSION"

# Install pyenv
curl https://pyenv.run | bash

# Add pyenv to PATH and initialize
export PATH="$HOME/.pyenv/bin:$PATH"
echo 'export PATH="$HOME/.pyenv/bin:$PATH"' >> ~/.bashrc

eval "$(pyenv init --path)"
echo 'eval "$(pyenv init --path)"' >> ~/.bashrc

eval "$(pyenv init -)"

eval "$(pyenv virtualenv-init -)"
echo 'eval "$(pyenv virtualenv-init -)"' >> ~/.bashrc

# Install the specified Python version
pyenv install $PYTHON_VERSION
pyenv global $PYTHON_VERSION

# Upgrade pip and install pip cache
pip install --upgrade pip
pip install pip-cache

echo "Python $PYTHON_VERSION setup complete with pip cache enabled."
