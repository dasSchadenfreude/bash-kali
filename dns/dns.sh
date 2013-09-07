#!/bin/bash

function install_dns_packaged(){
  sudo apt-get install -y dnstracer dnswalk > /dev/null
  }

function install_urlcrazy(){
  if [ ! -e ~/bin/urlcrazy ]
     then
     cd ~/dns
     wget http://www.morningstarsecurity.com/downloads/urlcrazy-0.5.tar.gz
     tar xf urlcrazy-0.5.tar.gz
     rm urlcrazy-0.5.tar.gz
     ln -s ~/dns/urlcrazy-0.5/urlcrazy ~/bin/urlcrazy
     cd -
  else
    echo "Already tried to install urlcrazy"
  fi
  }

function install_fierce(){
  '''
  http://www.aldeid.com/wiki/Fierce
  cpan[1]> install Net::CIDR
  cpan[2]> install Net::Whois::ARIN
  cpan[3]> install Object::InsideOut
  cpan[4]> install Template
  cpan[5]> install Test::Class
  cpan[6]> install Test::MockObject
  cpan[7]> install Net::DNS
  cpan[8]> install Net::hostent
  cpan[0]> install WWW::Mechanize
  '''
  echo "Fierce installation not implemented...god do I hate perl"
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
  #I hate perl, but I include it for people that use tool counts...
  #This will eventually be excluded in favor of a python tool that does the same.
  #This way, if I ever get around to doing an import Universal; found = dnsbrute('domain'); it can be implemented
  #as a single framework instead of disparate tools.
  sudo apt-get install -y libnet-netmask-perl libxml-writer-perl > /dev/null
  #at least there's this https://github.com/darkoperator/MSF-Installer/blob/master/msf_install.sh
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
}
