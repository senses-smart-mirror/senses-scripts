#!/bin/bash
function log() { echo "##" "$1"; }

dir=$PWD

printf "\n\n\n"
log "---------------------------- ##"
log "Smart Mirror Installation ... ##"
log "---------------------------- ##"
printf "\n"

log "[Smart Mirror] - Pre install started.."


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

FOUND=false
[ -d senses-smartmirror ] && FOUND=true || FOUND=false

if $FOUND;
  then
    log "[Smart Mirror] - Folder already present! You might want to consider updating.. aborting.."
    exit
fi

log "[Smart Mirror] - Downloading the Smart Mirror software."
printf "\n\n"
curl https://github.com/senses-smart-mirror/senses-smartmirror/releases/download/v1.0.3/senses-smartmirror.zip -O -J -L -o senses-smartmirror.zip

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