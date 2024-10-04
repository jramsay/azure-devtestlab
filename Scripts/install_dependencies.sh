#!/bin/bash

export HOME=${1:-"/home/devtestlab"}
export PYTHON_VERSION=${2:-"3.12"}

mkdir -p $HOME
cp *.sh $HOME
cd $HOME
sh $HOME/install_python.sh