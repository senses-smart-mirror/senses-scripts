#!/bin/bash
function log() { echo "##" "$1"; }

dir=$PWD

printf "\n\n"
log "---------------------------- ##"
log "Senses - Smart Mirror Installation ... ##"
log "---------------------------- ##"
printf "\n"

log "[Senses - Smart Mirror] - Pre install started.."
bash ./preinstall.sh

FOUND=false
[ -d senses-smartmirror ] && FOUND=true || FOUND=false

if $FOUND;
  then
    log "[Senses - Smart Mirror] - Folder already present! You might want to consider updating.. aborting.."
    exit
fi

log "[Senses - Smart Mirror] - Downloading the Senses - Smart Mirror software."
printf "\n\n"
curl -o senses-smartmirror.zip https://github.com/nickthesing/smart-mirror/releases/latest/download/senses-smartmirror.zip

FOUND=false
[ -f senses-smartmirror.zip ] && FOUND=true || FOUND=false

if $FOUND;
  then
   log "[Senses - Smart Mirror] - Package downloaded.."
  else 
    log "[Senses - Smart Mirror] - ERROR: Something went wrong.. Package is not downloaded. Please try again."
    exit
fi


log "[Senses - Smart Mirror] - Unzipping.."
unzip -q senses-smartmirror.zip

FOUND=false
[ -d senses-smartmirror ] && FOUND=true || FOUND=false

if $FOUND;
  then 
    log "[Senses - Smart Mirror] - Unzip successful! Moving on.."
  else 
    log "[Senses - Smart Mirror] - ERROR: Unzipping went wrong. Please try again."
    exit
fi

log "[Senses - Smart Mirror] - Installing Senses - Launcher functionality"
cd $dir/senses-smartmirror/
if npm install --quiet --no-progress --silent;
  then 
    log "[Senses - Smart Mirror] - Senses - Launcher installed!"
  else 
    log "[Senses - Smart Mirror] - ERROR: Senses -  Launcher not installed. Please try again."
    exit
fi 

log "[Senses - Smart Mirror] - Installing Senses - Server functionality"
cd $dir/senses-smartmirror/server
if npm install --quiet --no-progress --silent;
  then
    log "[Senses - Smart Mirror] - Senses - Server installed!"
  else
    log "[Senses - Smart Mirror] - ERROR: Senses - Server not installed. Please try again."
fi

log "[Senses - Smart Mirror] - Cleanup process started..."
cd $dir
rm senses-smartmirror.zip
rm -rf senses-smartmirror/app

log "[Senses - Smart Mirror] - Cleanup process finished."

log "[Senses - Smart Mirror] - We are done installing.. You can now run 'bash run.sh' to start the GUI"