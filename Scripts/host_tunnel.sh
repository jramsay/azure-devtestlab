#!/bin/bash

# Variables
PORT_NUMBER=${1:-5000}

export HOME="/home/devtestlab"
cd $HOME

python3 -m venv virtual_env
. virtual_env/bin/activate

python3 app.py &
pid=$!

output=$($HOME/bin/devtunnel login --mi-client-id 8286efbb-1b94-4821-8876-b87156372c08)
echo "$output"

output=$($HOME/bin/devtunnel create 2>&1)
exit_status=$?
if [ $exit_status -ne 0 ]; then
    echo "Create tunnel failed: $output"
else
    echo "Create tunnel succeeded"
    tunnel_id=$(echo "$output" | grep "Tunnel ID" | awk -F ': ' '{print $2}')
    echo "Tunnel ID: $tunnel_id"

    output=$($HOME/bin/devtunnel port create -p $PORT_NUMBER 2>&1)
    exit_status=$?
    if [ $exit_status -ne 0 ]; then
        echo "Create port failed: $output"
    else
        echo "Create port succeeded"
        port_number=$(echo "$output" | grep "Port Number" | awk -F ': ' '{print $2}')
        echo "Port Number: $port_number"
    fi
fi


