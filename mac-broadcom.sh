#!/bin/bash

# mac-broadcom.sh
#
# A script that installs the Broadcom driver for Macs that run Debian-based distros. 
#
# Copyright 2020-2021 Andrei Datcu <@datcuandrei>

echo "Welcome to mac-broadcom"
echo "This script will automatically update your system and install the Broadcom driver for your Mac."
echo "Before you proceed,please save all your work,as the script will automatically reboot your Mac after it is done."
echo "This script will run under root.Please enter your password when you are ready to proceed."
sudo su <<HERE
echo "Adding non-free source..."
echo "deb http://http.debian.net/debian/ bullseye main contrib non-free" >> ~/etc/apt/sources.list

echo "Updating system..."
sudo apt update
sudo apt upgrade

echo "Installing Broadcom driver..."
sudo apt-get install firmware-b43-installer
echo "Thank your for using mac-broadcom!The system will now reboot."
sudo reboot
HERE
