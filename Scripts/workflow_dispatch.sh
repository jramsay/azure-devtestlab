#!/bin/bash

# Variables
REPO=${1:-""}
REF=${2:-""}
PATCH=${3:-""}
COMMAND=${4:-""}

HOME="/home/devtestlab"
CLONE_DIR = "test_repo"
cd $HOME

source virtual_env/bin/activate

if [ -n "$REPO" ]; then
    echo "Cloning repo: $REPO"
    git clone $REPO $CLONE_DIR
    cd $CLONE_DIR
    if [ -n "$REF" ]; then
        echo "Check out ref: $REF"
        git checkout $REF
    fi
    echo "Repository cloned."
fi

if [ -n "$PATCH" ]; then
    echo "Patch input provided. Applying patch: $PATCH"
    cd $HOME/$CLONE_DIR
    echo $PATCH | base64 --decode | sed 's/\r$//'  > patch.diff
    echo "Decoded patch content:"
    cat patch.diff
    echo "Apply the patch:"
    git apply patch.diff || {
        echo "Failed to apply patch"
        exit 1
    }
fi

if [ -n "$COMMAND" ]; then
    echo "Start running custom command: $COMMAND"
    cd $HOME/$CLONE_DIR
    echo "${{ $COMMAND }}"
    output=$(echo "${{ $COMMAND }}" | base64 --decode | sed 's/\r$//')
    echo "Decoded custom command is:"
    echo $output
    echo "Command output:"
    eval $output
    echo "RAN_CUSTOM_COMMAND=true" >> $GITHUB_ENV
    echo "Finished running command"
fi

if [ -n "$REPO" ] || [ -n "$PATCH" ] || [ -n "$COMMAND" ] || [ -n "$REF" ]; then
    cd $HOME/$CLONE_DIR

    echo "Building"
    make

    echo "Running Tests"
    make ci
    echo "Finished running tests"
fi