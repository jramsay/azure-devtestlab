#!/bin/bash

# Variables
REPO=${1:-""}
PATCH=${2:-""}
COMMAND=${3:-""}
REF=${4:-""}

HOME="/home/devtestlab"
CLONE_DIR = "test_repo"
cd $HOME

if [ -n $REPO ]; then
    echo "Cloning repo..."
    git clone $REPO $CLONE_DIR
    cd $CLONE_DIR
    if [ -n $REF ]; then
        git checkout $REF
    fi
    echo "Repository cloned and checked out to ref $REF"
fi

if [ -n $PATCH ]; then
    echo "Patch input provided. Applying patch..."
    echo $PATCH | base64 --decode | sed 's/\r$//'  > patch.diff
    echo "Decoded patch content:"
    cat patch.diff
    echo "Apply the patch:"
    git apply patch.diff || {
        echo "Failed to apply patch"
        exit 1
    }
fi

if [ -n $COMMAND ]; then
     echo "Start running custom command"
    echo "${{ $COMMAND }}"
    output=$(echo "${{ $COMMAND }}" | base64 --decode | sed 's/\r$//')
    echo "Decoded custom command is:"
    echo $output
    echo "Command output:"
    eval $output
    echo "RAN_CUSTOM_COMMAND=true" >> $GITHUB_ENV
    echo "Finished running command!"
fi