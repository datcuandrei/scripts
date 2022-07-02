#!/usr/bin/env bash

clear
echo "Welcome to Linerra!"
echo "A simple way to get a macOS VM working correctly on Linux."
echo "=========================================================="
echo "Create a new VM in VirtualBox named 'Linerra'."
echo "Make sure the VM has at least 4GB and 2 or more CPU's, so it will run smoother."
read -n 1 -s -r -p "When you are done creating the VM, press any key to proceed."

echo "\n\nDownloading macOS Sierra VM..."

FILEID=1zrs0TauFo2MJ9WB-PD7F-y4Q_EnnVbWe
FILENAME=macOS_Sierra_10.12_by_wikigain.vmdk

#wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=$FILEID' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=$FILEID" -O $FILENAME && rm -rf /tmp/cookies.txt

wget --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate "https://docs.google.com/uc?export=download&id=$FILEID" -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p' > /tmp/confirm && wget --load-cookies /tmp/cookies.txt --no-check-certificate "https://docs.google.com/uc?export=download&confirm="$(cat /tmp/confirm)"&id=$FILEID" -O $FILENAME && rm /tmp/cookies.txt /tmp/confirm


echo "\nCopying the VDK..."
VM=Linerra

cp -avr $FILENAME ~/"VirtualBox VMs/$VM/"

echo "\nSetting up the VM to be usable..."
# Thanks to Helmreich Joinery's script

VBoxManage modifyvm $VM  --cpuidset 00000001 000306a9 00020800 80000201 178bfbff
VBoxManage setextradata "$VM" "VBoxInternal/Devices/efi/0/Config/DmiSystemProduct" "iMac11,3"
VBoxManage setextradata "$VM" "VBoxInternal/Devices/efi/0/Config/DmiSystemVersion" "1.0"
VBoxManage setextradata "$VM" "VBoxInternal/Devices/efi/0/Config/DmiBoardProduct" "Iloveapple"
VBoxManage setextradata "$VM" "VBoxInternal/Devices/smc/0/Config/DeviceKey" "ourhardworkbythesewordsguardedpleasedontsteal(c)AppleComputerInc"
VBoxManage setextradata "$VM" "VBoxInternal/Devices/smc/0/Config/GetKeyFromRealSMC" 1
VBoxManage setextradata "$VM" "VBoxInternal2/EfiGraphicsResolution" "1280x720"

echo "\nThe script has finished! Now you can add the hard disk from the HDD options in the VM and it should work without any issues."
echo "Thank you for using Linerra!"
