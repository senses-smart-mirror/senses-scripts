#!/bin/bash
function log() { echo "##" "$1"; }

dir=$PWD

printf "\n\n\n"
log "---------------------------- ##"
log "Smart Mirror Installation ... ##"
log "---------------------------- ##"
printf "\n"

log "[Smart Mirror] - Pre install started.."
bash ./preinstall.sh

FOUND=false
[ -d senses-smartmirror ] && FOUND=true || FOUND=false

if $FOUND;
  then
    log "[Smart Mirror] - Folder already present! You might want to consider updating.. aborting.."
    exit
fi

log "[Smart Mirror] - Downloading the Smart Mirror software."
printf "\n\n"
curl -o senses-smartmirror.zip https://downloadmirror.nl/senses-smartmirror.zip

FOUND=false
[ -f senses-smartmirror.zip ] && FOUND=true || FOUND=false

if $FOUND;
  then
   log "[Smart Mirror] - Package downloaded.."
  else 
    log "[Smart Mirror] - ERROR: Something went wrong.. Package is not downloaded. Please try again."
    exit
fi


log "[Smart Mirror] - Unzipping.."
unzip -q senses-smartmirror.zip

FOUND=false
[ -d senses-smartmirror ] && FOUND=true || FOUND=false

if $FOUND;
  then 
    log "[Smart Mirror] - Unzip successful! Moving on.."
  else 
    log "[Smart Mirror] - ERROR: Unzipping went wrong. Please try again."
    exit
fi

log "[Smart Mirror] - Installing Mirror Launcher functionality"
cd $dir/senses-smartmirror/
if npm install --quiet --no-progress --silent;
  then 
    log "[Smart Mirror] - Mirror Launcher installed!"
  else 
    log "[Smart Mirror] - ERROR: Mirror Launcher not installed. Please try again."
    exit
fi 

log "[Smart Mirror] - Installing Mirror Server functionality"
cd $dir/senses-smartmirror/server
if npm install --quiet --no-progress --silent;
  then
    log "[Smart Mirror] - Mirror Server installed!"
  else
    log "[Smart Mirror] - ERROR: Mirror Server not installed. Please try again."
fi

log "[Smart Mirror] - Cleanup process started..."
cd $dir
rm senses-smartmirror.zip
rm -rf senses-smartmirror/app

log "[Smart Mirror] - Cleanup process finished."

log "[Smart Mirror] - We are done installing.. You can now run 'bash run.sh' to start the GUI"