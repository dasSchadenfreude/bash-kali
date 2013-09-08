#!/bin/bash

function install_dns_packaged(){
  sudo apt-get install -y dnstracer dnswalk > /dev/null
  }

function install_urlcrazy(){
  cd ~/
  if [ ! -e bin/urlcrazy ]
     then
     cd ~/dns
     wget http://www.morningstarsecurity.com/downloads/urlcrazy-0.5.tar.gz
     tar xf urlcrazy-0.5.tar.gz
     rm urlcrazy-0.5.tar.gz
     ln -s ~/dns/urlcrazy-0.5/urlcrazy ~/bin/urlcrazy
     cd -
  else
    echo "Already tried to install urlcxrazy"
  fi
  cd ~/work/bash-kali
  }

function install_fierce(){
  if [ ! -d ~/dns/fierce2 ]
    then
      cd ~/dns
      svn co https://svn.assembla.com/svn/fierce/fierce2/trunk/ fierce2
      cd fierce2
      chmod +x install.sh
      sudo ./install.sh > /dev/null
    fi
  cd ~/work/bash-kali
  }

function install_dnsrecon_plugin(){
  cd ~/
  if [ -d 'metasploit-framework' ] && [ ! -e 'metasploit-framework/plugins/dnsr_import.rb' ]
    then
      echo "Installing DNSRecon Import plugin"
      cp virtual_env/dnsrecon/dnsrecon/msf_plugin/dnsr_import.rb metasploit-framework/plugins/dnsr_import.rb
  else
    echo "DNSREcon import already installed"
  fi
  cd ~/work/bash-kali
}

function install_dnsrecon_deps(){
  sudo apt-get install libavahi-compat-libdnssd1 git-core python-setuptools virtualenv
}

function install_dnsrecon(){
  cd ~/
  if [ ! -d "virtual_env/dnsrecon" ]
    then  
      install_dnsrecon_deps
      mkdir -p virtual_env
      cd virtual_env
      virtualenv dnsrecon
      cd dnsrecon
      source bin/activate
      pip install netaddr dnspython
      git clone https://github.com/darkoperator/dnsrecon.git > /dev/null
      deactivate
      #TODO add ~/bin
  else
    echo "Already tried to install dnsrecon"
  fi
  cd ~/work/bash-kali
  install_dnsrecon_plugin
  }

function install_dnsmap(){
  cd ~/
  if [ ! -e '~/bin/dnsmap' ]
    then
    mkdir -p ~/dns/dnsmap
    cd ~/dns/
    wget https://dnsmap.googlecode.com/files/dnsmap-0.30.tar.gz 2> /dev/null
    tar xf dnsmap-0.30.tar.gz
    rm dnsmap-0.30.tar.gz
    sed -i "s#/usr/local/bin#$HOME/bin#" dnsmap-0.30/Makefile  
    cd dnsmap-0.30
    make -s
    make -s install
    cd ..
    rm -Rf dnsmap-0.30
  else
    echo "Already tried to install dnsmap"
  fi
  cd ~/work/bash-kali
  }

function install_dnsenum_deps(){
  sudo apt-get install -y libnet-netmask-perl libxml-writer-perl > /dev/null
  }

function install_dnsenum(){
  cd ~/
  if [ -d dns/dnsenum ]
    then
      echo "Already tried to install dnsenum"
    else
      mkdir -p dns/dnsenum
      cd dns/dnsenum
      install_dnsenum_deps
      wget https://dnsenum.googlecode.com/files/dnsenum-1.2.2.tar.gz 2> /dev/null
      tar xf dnsenum-1.2.2.tar.gz
  fi
  cd ~/work/bash-kali
  }

function install_dns_tools(){
  install_dns_packaged
  source thc/thc_tools.sh
  install_thc_tools
  install_dnsmap
  install_dnsenum
  install_dnsrecon
  install_urlcrazy
  install_fierce
}
