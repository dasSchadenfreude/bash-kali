#!/bin/bash

#TODO
#add REINSTALL variable to bypass "already tried to install checks"
set REINSTALL = 0

#checksum verification for all http fetches - alternately mirror them as binary packages on launchpad

#add functions for each tool to create desktop files so they can be launched from unity

#add icons for each tool so they don't show up as question marks


function install_base(){
  echo "Installing base"
  source base/base.sh
  install_baseline
  configure_baseline
  }

function install_datarescue(){
  echo "IDA install not implemented"
  }

function install_dev(){
  echo "Devtools pulled in by base, no need for this function other than to explain that to you"
  }

function install_dns(){
  echo "Installing DNS"
  source dns/dns.sh
  install_dns_tools
  }

function install_idsips(){
  echo "Installing ids/ips tools"
  source idsips/idsips.sh
  install_ids_ips
  }

function install_immunity(){
  echo "Not impemented"
  }

function install_livehost(){
  source livehost/livehost.sh
  install_livehost_tools
  }

function install_net(){
  echo "Installing net"
  source network/network.sh
  install_net_test
  }

function install_osint(){
  echo "Installing osint"
  source osint/osint.sh
  install_stalkery_stuff
}

function install_plugins(){
  echo "Installing plugins"
  echo "Plug-ins are not yet tested, but if you look at how it's set up so far...I plan to implement iterating over scripts in the plugin folder.  Then source each one and run install_plugin..."
  }

function install_rapid7(){
  echo "Installing rapid7"
  source rapid7/rapid7.sh
  install_rapid7_tools
  }

function install_reporting(){
  echo "Installing reporting"
  source reporting/reporting.sh
  install_reporting_tools
}

function install_thc(){
  source thc/thc_tools.sh
  install_thc_tools
}

function install_web(){
  echo "Installing webapp"
  source network/network.sh
  install_dns
  source webapp/webapp.sh
  install_webapp
  }

function install_wordlists(){
  echo "Installing wordlists"
  source wordlists/wordlists.sh
  install_wordlist
  }

function install_all(){
  install_base
  install_datarescue
  install_dns
  install_idsips
  install_immunity
  install_livehost
  install_net
  install_osint
  install_rapid7
  install_reporting
  install_thc
  install_web
  install_wordlists
  install_plugins
  }