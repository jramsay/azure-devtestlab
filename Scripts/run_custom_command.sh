#!/bin/bash

# Variables
COMMAND=${1:-""} 

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