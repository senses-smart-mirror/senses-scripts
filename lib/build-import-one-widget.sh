#!/bin/bash

function log() { echo "$1"; }

dir=$PWD

log "[Mirror Scripts] - Package & Import Widget..."

sh scripts/build-widget.sh $1
cd $dir
sh scripts/import-widget.sh $1 $2