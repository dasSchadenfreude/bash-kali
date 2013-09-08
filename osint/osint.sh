#!/bin/bash

function install_stalkery_stuff(){
  cd ~/
  if [ ! -e bin/maltego ]
  	then
      sudo apt-get install creepy -y > /dev/null
      #bring the creepystuff
      mkdir ~/dumpthis
      cd ~/dumpthis
      git clone https://github.com/dasSchadenfreude/osintBlobs.git
      cd osintBlobs
      unzip MaltegoCE.v3.4.0.5004.zip
      unzip maltego-CF.1.0.1_community-2012-03-14.zip
      mkdir -p ~/stalkers_suck
      cp -R MaltegoTungstenCE3.4.0.5004 ~/stalkers_suck
      cp -R v3.0 ~/stalkers_suck
      cat > ~/bin/maltego << EOF
cd ~/stalkers_suck/MaltegoTungstenCE3.4.0.5004/bin
./maltego
EOF
      cat > ~/bin/casefile << EOF
cd ~/stalkers_suck/v3.0/bin
./maltego
EOF
      rm -Rf ~/dumpthis
      chmod +x ~/bin/maltego
      chmod +x ~/bin/casefile
  fi
  cd ~/work/bash-kali
  }
