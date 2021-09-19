#!/bin/bash

function log() { echo "$1"; }

log "[Mirror Scripts] - Package & Import Widget..."

sh scripts/build-widgets.sh $1
sh scripts/import-widgets.sh $1 $2