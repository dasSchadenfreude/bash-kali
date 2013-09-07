#!/bin/bash

function install_burp(){
  cd ~/
  if [ ! -d 'webapp/burp' ]
    then
      mkdir -p webapp/burp/burp
      cd webapp/burp/burp
      wget http://portswigger.net/burp/burpsuite_free_v1.5.jar
      mkdir -p ../extender/burp
      cd ../extender/burp
      wget http://portswigger.net/burp/extender/api/burp_extender_api.zip
      unzip burp_extender
      mkdir ../jython
      cd ../jython
      wget http://search.maven.org/remotecontent?filepath=org/python/jython/2.7-b1/jython-2.7-b1.jar
      cd ~/bin
      cat > burp << EOF
#!/bin/bash
cd ~/webapp/burp/burp
java -jar -Xmx1024m burpsuite_free_v1.5.jar
EOF

      cat > burp_sqlmap << EOF
#!/bin/bash
cd ~/webapp/burp/burp
java -classpath gason-0.9.5.jar:burpsuite_free_v1.5.jar burp.StartBurp
EOF
       chmod +x burp
       chmod +x burp_sqlmap
       cd ~/webapp/burp/burp
       wget https://gason.googlecode.com/files/gason-0.9.5.zip 2> /dev/null
       unzip gason-0.9.5.zip
       rm Changelog.txt gason-0.9.5.zip

    else
      echo "Already tried to get Burp suite, extender, and jython"
    fi
    cd ~/work/bash-kali
  }

function install_zap(){
  echo "Zap installation not implemented"
  #https://code.google.com/p/zaproxy/
  echo "Extension grabbing not yet implemented"
  #https://code.google.com/p/zap-extensions/downloads/list
  }

function install_webapp_packaged(){
  sudo apt-get install -y sqlmap > /dev/null
  }

function install_webapp(){
  source rapid7/rapid7.sh
  install_webapp_packaged
  install_w3af
  install_burp
  install_zap
  }