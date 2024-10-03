#!/bin/bash

# Variables
REPO_URL=${1:-""}
CLONE_DIR=${2:-""}
BRANCH_NAME=${3:-"main"}

# Clone the repository
git clone $REPO_URL $CLONE_DIR

# Navigate into the repository directory
cd $CLONE_DIR

# Checkout a specific branch (optional)
git checkout $BRANCH_NAME

echo "Repository cloned and checked out to branch $BRANCH_NAME"
