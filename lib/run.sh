#!/bin/bash

function log() { echo "##" "$1"; }

log "[Smart Mirror] - Starting ..."

cd smart-mirror

DISPLAY=:0 npm start &