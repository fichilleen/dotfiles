#!/bin/bash

# Setup symlinks to home directory
psettings=`pwd`
cd ~
ln -s $psettings/.z* .
ln -s $psettings/.v* .
