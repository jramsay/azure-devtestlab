#!/bin/bash

# Variables
PYTHON_VERSION=${1:-"3.12"}

# Set up Python

echo "Setting up Python $PYTHON_VERSION"

# Install pyenv
curl https://pyenv.run | bash

# Add pyenv to PATH and initialize
export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# Install the specified Python version
pyenv install $PYTHON_VERSION
pyenv global $PYTHON_VERSION

# Upgrade pip and install pip cache
pip install --upgrade pip
pip install pip-cache

echo "Python $PYTHON_VERSION setup complete with pip cache enabled."