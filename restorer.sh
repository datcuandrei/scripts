#!/usr/bin/env bash

backup_path=$@

echo "Extracting backup..."
echo "--------------------"
7z x $backup_path 

echo "Restoring files..."
echo "------------------"
cd "$(pwd)/backup" && cp -avr * "$HOME"

echo "!! Installing a package requires super user privileges."
echo "-------------------------------------------------------"

cat "$(pwd)/packages.txt" | while read package; do
	sudo su <<HERE
		pacman -Syy $package
	HERE
done

rm -rf "$HOME/backup" "$HOME/filelist.txt" "$HOME/packages.txt"
