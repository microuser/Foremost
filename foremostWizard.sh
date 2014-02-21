#!/bin/sh



#Install Prerequisits
needsInstallRsync=`sudo apt-cache policy rsync | grep 'Installed: (none)' | wc -l`
needsInstallDialog=`sudo apt-cache policy dialog | grep 'Installed: (none)' | wc -l`
if [ $needsInstallRsync = 1 ]; then
	sudo apt-get install rsync;
fi
if [ $needsInstallDialog = 1 ]; then
	sudo apt-get install dialog;
fi

_temp="/tmp/foremost.$$"

selectSourceDirectory() {

    dialog --backtitle "Instructions: Use the tab and arrow keys to navigate. Use the [space] to choose the path of the selected item"\
           --begin 3 10 --title "SOURCE folder itself"\
           --dselect "$HOME/" 10 60 2>$_temp
    sourceDirectory=`cat $_temp`
}
selectDestinationDirectory() {

    dialog --backtitle "Select the DESTINATION's (parent) folder of where to place the SOURCE inside of."\
           --begin 3 10 --title "DESTINATION's (parent) folder"\
           --dselect "$HOME/" 10 60 2>$_temp
    destinationDirectory=`cat $_temp`
}
selectBackupMode() {
    dialog --backtitle "Choose rsync file transfer options" \
           --radiolist "Choose rsync transfer mode" 15 50 8 \
           "Archive Mode" "(Add Files Only)" on\
           "Mirror Mode" "(Delete Unneeded Files)" off\
           "Synchronize" "(Priority Source)" off\
		2>$_temp
    backupMode=`cat $_temp`
}    
dialog --msgbox "Welcome to the Foremost GUI\n\nBy microuser@github (2014)\nFor updates see https://github.com/microuser/Foremost" 10 40

selectSourceDirectory
selectDestinationDirectory
selectBackupMode

if [ "$backupMode" = "Archive Mode" ]; then
	dialog --msgbox "Archive Mode" 20 20
	rsyncCommand="rsync -av"
	$rsyncCommand "$sourceDirectory" "$destinationDirectory"
fi

if [ "$backupMode" = "Mirror Mode" ]; then
	rsyncCommand="rsync -av --delete"
	$rsyncCommand "$sourceDirectory" "$destinationDirectory"
fi

if [ "$backupMode" = "Synchronize" ]; then
	rsyncCommand="rsync -av"
	$rsyncCommand "$sourceDirectory" "$destinationDirectory"
	$rsyncCommand "$destinationDirectory" "$sourceDirectory"
fi


echo " " 
echo The above output was created using the command:
echo $rsyncCommand \"$sourceDirectory\" \"$destinationDirectory\";
if [ "$backupMode" = "Synchronize" ]; then
echo $rsyncCommand \"$destinationDirectory\" \"$sourceDirectory\"
fi


