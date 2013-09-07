#!/bin/bash

function install_net_test(){
  sudo apt-get install -y dmitry netdiscover netmask sslscan nbtscan > /dev/null
  source rapid7/rapid7.sh
  install_metasploit
  install_armitage
  source dns/dns.sh
  install_dns
  }