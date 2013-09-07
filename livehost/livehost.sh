#!/bin/bash

function install_livehost_packaged(){
  sudo apt-get install -y arping hping3 netdiscover fping xprobe > /dev/null
}
function install_livehost(){
  source thc/thc_tools.sh
  install_thc_tools
}
