#!/bin/bash

function log() { echo "$1"; }

if [ -z $1 ]; 
  then 
    log "[Mirror - Scripts] - Error: No name for the widget specified. Please specify a name. Aborting..";
    exit; 
  else log "[Mirror - Scripts] - Widget name: '$1'"; 
fi

log "[Mirror - Scripts] - Creating new widget: $1"
log "[Mirror - Scripts] - Folder: $PWD/$2"

startDir=$PWD
cd $2

FOUND=false
[ -d $1 ] && FOUND=true || FOUND=false
if $FOUND; then
  log "[Mirror - Scripts] - widget with name ($1) already found. Choose a different name or remove the folder first."
  exit
 fi

mkdir $1
cd $1

dir=$PWD

cd $dir
mkdir -p server/src

n=""
IFS='- ' read -r -a array <<< "$1"
for element in "${array[@]}"
do
  n+=`echo ${element:0:1} | tr  '[a-z]' '[A-Z]'`${element:1}
done

log "[Mirror - Scripts] - Create config & server file."

sed -e "s/{{name}}/$n/g" -e "s/{{nickname}}/$1/g" $startDir/blueprints/config.ts > $dir/server/src/$1-config.ts
sed "s/Name/$n/g" $startDir/blueprints/helper.ts > $dir/server/src/$1-helper.ts

log "[Mirror - Scripts] - Copying configuation files."

cp $startDir/blueprints/.babelrc $dir/server/.babelrc
cp $startDir/blueprints/tsconfig.json $dir/server/tsconfig.json
cp $startDir/blueprints/webpack.config.js $dir/server/webpack.config.js
cp $startDir/blueprints/package.json $dir/server/package.json
cp $startDir/blueprints/smart-mirror.d.ts $dir/server/smart-mirror.d.ts

log "[Mirror - Scripts] - Install Server dependencies."

cd $dir/server/
npm install --quiet --no-progress --silent

cd $dir

log "[Mirror - Scripts] - Create project GUI."
vue create gui --bare --skipGetStarted --preset $startDir/blueprints/smart-mirror-preset.json 2>&1 >/dev/null

log "[Mirror - Scripts] - Copy README file."
cp $startDir/blueprints/README.md $dir

cd $dir/gui/src
mkdir components

log "[Mirror - Scripts] - Create widget component.".
sed "s/{{name}}/$1/g" $startDir/blueprints/sample.vue > $dir/gui/src/components/$1.vue

log "[Mirror - Scripts] - Widget GUI created.".
log "[Mirror - Scripts] - All done. Happy coding!".