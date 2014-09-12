#!/bin/bash
packages="zsh vim gcc g++ python3.2 git"

if [ -f /etc/debian_version ]; then
    sudo apt-get install $packages
elif [ -f /etc/redhat-release ]; then
    sudo yum install $packages
fi
