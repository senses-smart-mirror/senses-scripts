#!/bin/bash
function log() { echo "$1"; }

#
# start it all
#
root=$PWD

if [ -z $1 ]; 
  then 
    log "[Mirror Scripts] - No root folder specified.. aborting..";
    exit; 
  else log "[Mirror Scripts] - Building all widgets from folder: '$1'"; 
fi

# loop through all widgets in the folder and execute a build
cd $PWD/$1

for d in *; do
  sh ../scripts/build-widget.sh $d
done
