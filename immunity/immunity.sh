#!/bin/bash

function install_spike(){
  echo "Install spike not implemented"
  #wget http://www.immunitysec.com/downloads/SPIKE2.9.tgz
  #test compile worked, i'm just a little lazy right now
}

function install_spikeproxy(){
  echo "Installing spikeproxy"
  sudo apt-get install -y spikeproxy > /dev/null
}

function install_immdbg(){
  echo "ImmDbg installation not implemented"
  #will install in a wineprefix
}

function install_immunity(){
  install_spike
  install_spike_proxy
  install_immdbg
}
