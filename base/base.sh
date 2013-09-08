#!/bin/bash

function enable_uber_writer(){
  if [ -e "/etc/apt/sources.list.d/w-vollprecht-ppa-precise.list" ]
  then
    echo "Already enable_schadenfreude add uberwriter"
  else
    sudo add-apt-repository ppa:w-vollprecht/ppa
  fi  
}
function enable_pi_rho(){
  if [ -e "/etc/apt/sources.list.d/pi-rho-security-precise.list" ]
    then
      echo "Already enabled pi-rho"
    else
      sudo apt-add-repository ppa:pi-rho/security
  fi
  }

function enable_qt5(){
  if [ -e "/etc/apt/sources.list.d/ubuntu-sdk-team-ppa-precise.list" ]
    then
      echo "Already enabled qt5"
    else
      sudo apt-add-repository ppa:ubuntu-sdk-team/ppa
  fi
  }

function enable_webupd8(){
  if [ -e "/etc/apt/sources.list.d/webupd8team-sublime-text-2-precise.list" ]
    then
      echo "Already enabled sublime-text-2"
  fi
  }

function enable_per_user(){
  if [ ! -d $HOME"/bin" ]
    then
      echo "Creating per user bin folder"
      mkdir -p ~/bin 
    else
      echo "Already tried to enable per user bin folder"
  fi
  }

function enable_schadenfreude(){
  #I'm forking some repos and using source tracking and automated builds to make things work better
  #as it should be done.  When I get all the builds migrated to automated, everything will be running
  #from head.

  #For now, it's just a couple of binary tools.  Python tools don't need this because of virtualenv

  #Ruby tools don't need this because of rvm

  if [ -e "/etc/apt/sources.list.d/d-schadenfreude-007-sectools-precise.list" ]
    then
      echo "Already enabled schadenfreude"
    else
      sudo apt-add-repository ppa:d-schadenfreude-007/sectools
  fi
  }

function enable_per_user(){
  if [ ! -d $HOME"/bin" ]
    then
      mkdir ~/bin
  fi
  }

function apt_update(){
  echo "Updating with apt"
  sudo apt-get update > /dev/null
  sudo apt-get upgrade -y > /dev/null
  sudo apt-get dist-upgrade -y > /dev/null
}

function enable_ppas(){
  enable_pi_rho
  enable_qt5
  enable_webupd8
  enable_schadenfreude
  enable_uber_writer
}

function install_baseline(){
  enable_per_user
  echo "Enabling ppas"
  enable_ppas
  apt_update
  echo "Installing dev tools"
  source dev_tools/devtools.sh
  install_dev_tools
  #this is only here for the time being.  it will be moved to the relevant function or functions eventually
  sudo apt-get install -y aircrack-ng kismet python-distorm3 guake > /dev/null
  apt_update
  }

function configure_baseline(){
  echo "#TODO add configuration eye candy and whatnot stuff here"
  }
