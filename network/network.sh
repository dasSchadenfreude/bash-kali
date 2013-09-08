#!/bin/bash

function install_darkoperator_pentest_plugin(){
  cd ~/
  #blob from darkoperator's installer sort of
  if [ ! -e 'metasploit-framework/plugins/pentest.rb' ]
  	then
    echo "Installing pentest plugin"
    curl -# -o metasploit-framework/plugins/pentest.rb https://raw.github.com/darkoperator/Metasploit-Plugins/master/pentest.rb
    if [ $? -eq 0 ]
    	then
        echo "The pentest plugin has been installed."
    else
        echo "Failed to install the pentest plugin."
    fi
  fi
  cd ~/work/bash-kali
  }

function install_nmap(){
  echo "Installing nmap"
  sudo apt-get install -y nmap > /dev/null
  sudo apt-get install -y -f nmap-data > /dev/null
  sudo apt-get install -y nmap > /dev/null
}

function install_net_test(){
  install_nmap
  sudo apt-get install -y dmitry netdiscover netmask sslscan nbtscan amap > /dev/null
  source rapid7/rapid7.sh
  install_metasploit
  install_armitage
  source dns/dns.sh
  install_dns
  install_darkoperator_pentest_plugin
  }