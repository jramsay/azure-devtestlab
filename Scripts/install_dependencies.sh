#!/bin/bash

export HOME=${1:-"/home/devtestlab"}

mkdir -p $HOME
cp *.sh $HOME
cd $HOME
ln -s /usr/bin/python3 /usr/bin/python
python3 -m venv virtual_env