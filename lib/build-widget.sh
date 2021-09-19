#!/bin/bash

# functions:
function log() { echo "$1"; }

#
# do gui (vuejs) install & build 
#
function do_gui_build() {
  log "[Mirror Scripts] - Building GUI: $1"

  cd gui

  # get only name from folder
  name=${1##*/}

  FOUND=false
  [ -f package.json ] && FOUND=true || FOUND=false

  if $FOUND; then
    log "[Mirror Scripts] - package.json found."
  else
    log "[Mirror Scripts] - NO package.json found. exiting.."
    exit
  fi

  log "[Mirror Scripts] - Building GUI.."
  npm run build -- --prod --silent --verbose --target lib --formats umd-min --name "$name.[chunkhash]" src/components/$name.vue 2>&1 >/dev/null

  cp dist/* ../dist
}

#
# zip dist folder
#
function zip_all() {
  log "[Mirror Scripts] - Create zip file.."
  name=${1##*/}
  cd dist
  zip -r ../$name.zip *
}

#
# do server install packages & build
#
function do_server_build() {
  log "[Mirror Scripts] - Building Server: $1"

  cd server

  log "[Mirror Scripts] - Build"

  npm run bundle

  cp -R dist/ ../dist
}

#
# start it all
#
root=$PWD

if [ -z $1 ]; 
  then 
    log "[Mirror Scripts] - No widget folder specified.. aborting..";
    exit; 
  else log "[Mirror Scripts] - Building widget: $1"; 
fi

# - - - - - 

# start script
cd $PWD/$1
dir=$PWD

# remove zip file is already present.
FOUND=false
name=${1##*/}
[ -f $name.zip ] && FOUND=true || FOUND=false
if $FOUND; then
  rm $name.zip
fi

# remove dist folder if already present
FOUND=false
[ -d dist ] && FOUND=true || FOUND=false

if $FOUND; then
  rm -rf dist
fi

# create dist folder
mkdir dist

# compile server files and copy the files to dist folder
do_server_build $1

# back to root
cd $dir

# build .vue files and copy the files to dist folder
do_gui_build $1

# create zip file from all the files
cd $dir
zip_all $1

# all ready:
log "[Mirror Scripts] - Widget: '$1' build & packaged! \n"
