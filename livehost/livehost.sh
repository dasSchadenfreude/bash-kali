#!/bin/bash

function install_livehost_packaged(){
  echo "Installing pakaged tools"
  sudo apt-get install -y -f nmap-data > /dev/null
  sudo apt-get install -y iputils-arping hping3 netdiscover fping xprobe nmap > /dev/null
}

function install_cdpsnarf(){
  echo "Installing cdpsnarf"
  cd ~/
  if [ ! -d net/cdpsnarf ]
  	then
  	mkdir -p net
  	cd net
    git clone https://github.com/Zapotek/cdpsnarf
    cd cdpsnarf
  fi
  cd ~/work/bash-kali
}

function install_miranda(){
  echo "Installing miranda"
  cd ~/
  if [ ! -d net/miranda ]
    then
    wget https://miranda-upnp.googlecode.com/files/miranda-1.3.tar.gz 2> /dev/null
    tar xf miranda-1.3.tar.gz
  fi
  cd ~/work/bash-kali
}

function install_wole(){
  echo "Installing wol-e"
  cd ~/
  if [ ! -d net/wol-e ]
  	then
  	wget https://wol-e.googlecode.com/files/wol-e-2.0.tar
  fi
  cd ~/work/bash-kali
}

function install_livehost_tools(){
  source thc/thc_tools.sh
  install_thc_tools
  install_livehost_packaged
  install_cdpsnarf
  install_miranda
  install_wole
}
