#!/bin/bash

# bootcamp-patcher.sh
#
# A shell script that enables creation of Windows install disks on Boot Camp Assistant.
#
# - To patch Boot Camp Assistant,run :
#
# sh bootcamp-patcher.sh patch
#
# - To restore Boot Camp Assistant to initial state,run :
#
# sh bootcamp-patcher.sh unpatch
#
# Copyright 2020 Andrei Datcu <@datcuandrei>

sudo su <<HERE
case "$1" in
	patch)
		cd /Applications/Utilities/Boot\ Camp\ Assistant.app/Contents/
		sed -i '' 's/PreUSBBootSupportedModels/USBBootSupportedModels/g' Info.plist
		sed -i '' 's/MacBook7,1/$(sysctl -n hw.model)/g' Info.plist
		echo "Enabled Windows install disk creation for $(sysctl -n hw.model)"
		;;
	unpatch)
	cd /Applications/Utilities/Boot\ Camp\ Assistant.app/Contents/
		sed -i '' 's/USBBootSupportedModels/PreUSBBootSupportedModels/g' Info.plist
		sed -i '' 's/$(sysctl -n hw.model)/MacBook7,1/g' Info.plist
		echo "Disabled Windows install disk creation for $(sysctl -n hw.model)"
		;;
esac
if [ $? -eq 1 ]
then
  	echo "Patcher failed,please try again." >&2
  	exit 1
fi
HERE
