#!/bin/bash

function log() { echo "$1"; }

log "[Mirror - Scripts] - Importing one widget."

if [ -z $1 ];
  then 
    log "[Mirror - Scripts] - No root folder specified.. aborting..";
    exit; 
  else log "[Mirror - Scripts] - Importing from folder: '$1'"; 
fi

if [ -z $2 ]; 
  then 
    log "[Mirror - Scripts] - No target IP specified.. Aborting..";
    exit; 
  else log "[Mirror - Scripts] - Importing to: '$2'"; 
fi

cd $PWD/$1
dir=$PWD

name=${1##*/}
FOUND=false
[ -f $name.zip ] && FOUND=true || FOUND=false

if $FOUND; then
  log "[Mirror - Scripts] - Importing widget: $name"
  log "[Mirror - Scripts] - Importing to url: $2"
  
  IP=$2

  echo $dir

  if ping -c 1 $IP &>/dev/null; then
    curl -s -F "data=@$dir/$name.zip" http://$2:7011/api/package
    log "\n[Mirror - Scripts] - Import success!"
  else
    log "[Mirror - Scripts] - Error! seems like ($2) is down"
    exit;
  fi
else
  log "[Mirror - Scripts] - No zipfile found for widget: $name"
fi