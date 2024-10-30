#!/bin/bash

export HOME=${1:-"/home/devtestlab"}

mkdir -p $HOME
cp *.sh $HOME
cp *.py $HOME
cd $HOME
ln -s /usr/bin/python3 /usr/bin/python
python3 -m venv virtual_env

pip3 install Flask

python3 app.py &
pid=$!

echo "Python app launched with PID: $pid"

sudo apt-get update
sudo apt-get install curl
curl -sL https://aka.ms/DevTunnelCliInstall | bash
source ~/.bashrc

