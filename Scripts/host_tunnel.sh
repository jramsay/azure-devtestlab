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

output=$($HOME/bin/devtunnel create -a 2>&1)
exit_status=$?
if [ $exit_status -ne 0 ]; then
    echo "Create tunnel failed: $output"
else
    echo "Create tunnel succeeded"
    tunnel_id=$(echo "$output" | grep "Tunnel ID" | awk -F ': ' '{print $2}')
    echo "Tunnel ID: $tunnel_id"

    $output=$(devtunnel host $tunnel_id -p $PORT_NUMBER 2>&1 > /dev/null &)
    exit_status=$?
    if [ $exit_status -ne 0 ]; then
        echo "Hosting tunnel on port $PORT_NUMBER failed: $output"
    else
        echo "Hosting tunnel succeeded"
        echo "Connection Uri: https://$tunnel_id.devtunnels.ms:$port_number"
    fi
fi
