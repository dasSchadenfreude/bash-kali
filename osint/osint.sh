#!/bin/bash

function install_twofi(){
  wget http://www.digininja.org/files/twofi_1.0.tar.bz2
}

function install_theharvester(){
  mkdir -p ~/osint
  cd ~/osint
  if [ ! -d theharvester ]
  svn checkout http://theharvester.googlecode.com/svn/trunk/ theharvester
  cd ~/work/bash-kali
}

function install_metagoofil(){
  mkdir -p ~/osint
  cd ~/osint
  if [ ! -d metagoofil ]
    then
    echo "Installing metagoofil"
    svn checkout http://metagoofil.googlecode.com/svn/trunk/ metagoofil
  else
    echo "Already tried to install metagoofil"
  fi
  cd ~/work/bash-kali
}

function install_creepy(){
  echo "Installing creepy"
  sudo apt-get install creepy -y > /dev/null
}

function install_maltego_casefile(){
  cd ~/
  if [ ! -e bin/maltego ]
    then
      #bring the creepystuff
      echo "Installing Casefile and Maltego"
      mkdir ~/dumpthis
      cd ~/dumpthis
      git clone https://github.com/dasSchadenfreude/osintBlobs.git
      cd osintBlobs
      unzip MaltegoCE.v3.4.0.5004.zip
      unzip maltego-CF.1.0.1_community-2012-03-14.zip
      mkdir -p ~/osint
      cp -R MaltegoTungstenCE3.4.0.5004 ~/osint
      cp -R v3.0 ~/osint
      cat > ~/bin/maltego << EOF
cd ~/osint/MaltegoTungstenCE3.4.0.5004/bin
./maltego
EOF
      cat > ~/bin/casefile << EOF
cd ~/osint/v3.0/bin
./maltego
EOF
      rm -Rf ~/dumpthis
      chmod +x ~/bin/maltego
      chmod +x ~/bin/casefile
  else
    echo "Already installed maltego and casefile"
  fi
  cd ~/work/bash-kali  
}

function install_stalkery_stuff(){
  install_maltego_casefile
  install_metagoofil
  install_theharvester
  }
