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
[ -d smart-mirror ] && FOUND=true || FOUND=false

if $FOUND;
  then
    log "[Smart Mirror] - Folder already present! You might want to consider updating.. aborting.."
    exit
fi

log "[Smart Mirror] - Downloading the Smart Mirror software."
printf "\n\n"
curl -o smart-mirror.zip https://downloadmirror.nl/smart-mirror.zip

FOUND=false
[ -f smart-mirror.zip ] && FOUND=true || FOUND=false

if $FOUND;
  then
   log "[Smart Mirror] - Package downloaded.."
  else 
    log "[Smart Mirror] - ERROR: Something went wrong.. Package is not downloaded. Please try again."
    exit
fi


log "[Smart Mirror] - Unzipping.."
unzip -q smart-mirror.zip

FOUND=false
[ -d smart-mirror ] && FOUND=true || FOUND=false

if $FOUND;
  then 
    log "[Smart Mirror] - Unzip successful! Moving on.."
  else 
    log "[Smart Mirror] - ERROR: Unzipping went wrong. Please try again."
    exit
fi

log "[Smart Mirror] - Installing Mirror Launcher functionality"
cd $dir/smart-mirror/
if npm install --quiet --no-progress --silent;
  then 
    log "[Smart Mirror] - Mirror Launcher installed!"
  else 
    log "[Smart Mirror] - ERROR: Mirror Launcher not installed. Please try again."
    exit
fi 

log "[Smart Mirror] - Installing Mirror Server functionality"
cd $dir/smart-mirror/server
if npm install --quiet --no-progress --silent;
  then
    log "[Smart Mirror] - Mirror Server installed!"
  else
    log "[Smart Mirror] - ERROR: Mirror Server not installed. Please try again."
fi

log "[Smart Mirror] - Cleanup process started..."
cd $dir
rm smart-mirror.zip
rm -rf smart-mirror/app

log "[Smart Mirror] - Cleanup process finished."

log "[Smart Mirror] - We are done installing.. You can now run 'bash run.sh' to start the GUI"