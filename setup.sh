#!/bin/bash

# Setup symlinks to home directory
psettings=`pwd`
cd ~
mkdir .i3
ln -s $psettings/.z* .
ln -s $psettings/.v* .
ln -s $psettings/i3config ~/.i3/config
