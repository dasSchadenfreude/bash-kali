#!/bin/bash

function install_dev_tools(){
  #Installs lots of stuff you don't need, but I do...so it's in here.
  sudo apt-get install -y git mercurial subversion sublime-text build-essential iw bzr-builder pbuilder debhelper > /dev/null
}
