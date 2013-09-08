#!/bin/bash

function install_rockyou(){
  cd ~/wordlists
  if [ ! -e 'rockyou.txt' ]
  	then
    echo "I left the progress bar on with this one, because it can take a while..."
    wget http://downloads.skullsecurity.org/passwords/rockyou.txt.bz2
    bunzip2 rockyou.txt.bz2
  else
  	echo "rockyou already downloaded"
  cd ~/work/bash-kali
fi
}

function install_wordlist(){
  mkdir -p ~/wordlists
  install_rockyou
  cd ~/work/bash-kali
}