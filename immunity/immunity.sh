#!/bin/bash

function install_spike(){
  echo "not implemented"
  #wget http://www.immunitysec.com/downloads/SPIKE2.9.tgz
}

function install_spikeproxy(){
  sudo apt-get install -y spikeproxy > /dev/null
}

function install_immdbg(){
  echo "not implemented"
}

function install_immunity(){
  install_spike
  install_spike_proxy
  install_immdbg
}
