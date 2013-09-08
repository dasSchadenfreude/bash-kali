#!/bin/bash

function install_fragroute_deps(){
  sudo apt-get install libevent-dev libdnet-dev libdumbnet-dev -y > /dev/null
  }

function install_fragroute(){
  if [ ! -e /usr/local/sbin/fragroute ]
  	then
    mkdir -p ~/idsips
    cd ~/idsips
    wget http://www.monkey.org/~dugsong/fragroute/fragroute-1.2.tar.gz
    tar xf fragroute-1.2.tar.gz
    install_fragroute_deps
    cd fragroute-1.2
    sudo ln -s /usr/include/dumbnet.h /usr/include/dnet.h
    ./configure --with-libevent=/usr --with-libdnet=/usr
    grep -Ev 'event_sigcb|event_gotsig' fragroute.c > fragroute.c.out
    mv fragroute.c.out fragroute.c
    make
    sudo make install
  else
    echo "Already tried to install fragroute"
  fi
  cd ~/work/bash-kali
  }

function install_fragrouter_deps(){
	sudo apt-get install libnet-dev
  }

function install_fragrouter(){
	#stuck...moving on
  if [ ! -e /usr/local/sbin/fragrouter ]
  	then
  	mkdir -p ~/idsips
  	cd ~/idsips
    wget http://packetstorm.igor.onlinedirect.bg/UNIX/IDS/fragrouter-1.6.tar.gz
    tar xf fragrouter-1.6.tar.gz
    rm fragrouter-1.6.tar.gz
    cd fragrouter-1.6
  else
	echo "Already tried to install fragrouter"
  fi
  cd ~/work/bash-kali
  }

function wafwoof(){
  cd ~/
  mkdir -p idsips/wafwoof
  if [ ! -d idsips/wafwoof/waffit]
    then
    cd idsips/wafwoof
    svn checkout http://waffit.googlecode.com/svn/trunk/ waffit
    #TODO add ~/bin script
  fi
  }

function install_ids_ips(){
  install_fragroute
  }

