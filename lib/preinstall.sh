#!/bin/bash

# Installer scirpt for the smart mirror

function version_gt () { test "$(echo "$@" | tr " " "\n" | sort -V | head -n 1)" != "$1"; }
function command_exists () { type "$1" &> /dev/null ; }
function log () { echo '##' $1 ; }

# Update before first apt-get
log "[Smart Mirror] - updating packages ..."
sudo apt-get update || echo -e "## [Smart Mirror] - Update failed, carrying on installation ..."

#
# Variables
#
NODE_REQUIRED_VERSION="15.14.1"
NODE_STABLE_BRANCH="15.14.0"
NODE_INSTALL=false


# 
# Check node installation
#
if ! command_exists node;
	then
		# install node
		log '[Smart Mirror] - Going to install node'
    NODE_INSTALL=true
	else
		log "[Smart Mirror] - Node is installed, checking version" 
		NODE_CURRENT=$(node --version)
		log "[Smart Mirror] - Installed version: $NODE_CURRENT"
		log "[Smart Mirror] - Required version: $NODE_REQUIRED_VERSION"

		if version_gt $NODE_REQUIRED_VERSION ${NODE_CURRENT//v}; 
			then
				NODE_INSTALL=true
				log "[Smart Mirror] - Node requires an update."
			else
				log "[Smart Mirror] - Node is already installed"
		fi
fi

if $NODE_INSTALL; then
	log "[Smart Mirror] - Installing Node.js ..."

 	curl -sL https://deb.nodesource.com/setup_14.x| sudo -E bash -
 	sudo apt-get install -y nodejs

  echo "Node Version:"
  nodejs -v
	echo -e "\e[92m ## Node.js installation Done!\e[0m"
fi

sudo apt-get install -y npm