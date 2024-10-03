#!/bin/bash

# Variables
PATCH=${1:-""}

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
else
echo "No patch input provided. Skipping patch application."
fi
echo "Print git diff on local repo"
git diff
