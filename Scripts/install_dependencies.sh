#!/bin/bash

export HOME=${1:-"/home/devtestlab"}

mkdir -p $HOME
cp *.sh $HOME
cp *.py $HOME
cd $HOME
ln -s /usr/bin/python3 /usr/bin/python
python3 -m venv virtual_env
. virtual_env/bin/activate

pip3 install Flask

echo "Python app launched with PID: $pid"

apt-get update
apt-get install curl
curl -sL https://aka.ms/DevTunnelCliInstall | bash
. ~/.bashrc

