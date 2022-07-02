#!/usr/bin/env bash

backup_path=$(pwd)/backup
echo "Path for backup: $backup_path"
if [[ -e $backup_path ]]; then
	echo "Backup folder already exists! Overwriting..."
	rm $backup_path/*
else
	mkdir $backup_path
fi

ls /home/$USER > $backup_path/home.txt
ls /home/$USER -gh | grep - -n 
echo "-------------------------------------------------------------------"
echo "Please select which files you want to save from the home folder[2-$(ls /home/$USER -gh | wc -l)]: "
read files

echo $files | tr " " "\n" > $backup_path/files.txt

selected_files=(`cat "$backup_path/files.txt"`) 
for i in "${selected_files[@]}"; do
	let "index=$i-1"
	echo /home/$USER/$(cat $backup_path/home.txt | head -$index | tail +$index) >> $backup_path/filelist.txt
done

rm $backup_path/home.txt $backup_path/files.txt
echo "Backing up files from home directory..."
echo "------------------------------------"
cat $backup_path/filelist.txt | while read file; do
	cp -avr "$file" $backup_path
done

echo ""
echo "Retrieving a list of all packages..."
echo "------------------------------------"
pacman -Qet | awk '{print $1}' > $backup_path/packages.txt

echo "The packages found were saved under $backup_path/packages.txt"

echo ""
echo "Archiving backup..."
echo "-------------------"
7z a $(pwd)/backup.7z $backup_path

echo "Finishing up..."
echo "---------------"
rm -rf $backup_path
