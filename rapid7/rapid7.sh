#!/bin/bash


function install_armitage(){
  cd ~/
  if [ ! -d 'armitage' ]
    then
      #It's not available via https
      wget http://www.fastandeasyhacking.com/download/armitage20130605.tgz > /dev/null
      tar xf armitage20130605.tgz
      echo "export MSF_DATABASE_CONFIG=`pwd`/config/database.yml" >> .bashrc
    else
      echo "Already tried to install armitage"
  fi      
  cd ~/work/bash-kali
  }

function install_w3af_deps(){
  sudo apt-get install -y graphviz python2.7-dev libsqlite3-dev \
    libxslt1-dev python-gtksourceview2 libxml2-dev libcairo2-dev \
    python-gtk2  > /dev/null
  }

function install_w3af(){
  cd ~/
  if [ ! -d "virtual_env/w3af" ]
    then  
      install_w3af_deps
      mkdir virtual_env
      cd virtual_env
      virtualenv w3af
      cd w3af
      source bin/activate
      git clone https://github.com/andresriancho/w3af.git
      pip install clamd PyGithub GitPython pybloomfiltermmap \
        esmre nltk chardet pdfminer futures pyOpenSSL lxml \
        scapy-real guess-language cluster msgpack-python \
        python-ntlm xdot
      pip install -e git+git://github.com/ramen/phply.git#egg=phply

      ln -sf /usr/lib/python2.7/dist-packages/{glib,gobject,cairo,gtk-2.0,pygtk.py,pygtk.pth,gtksourceview2.so} lib/python2.7/site-packages
      deactivate
  fi
  cd ~/work/bash-kali
  }

function install_rvm(){
  if grep -q "source /usr/local/rvm/scripts/rvm" ~/.bashrc
    then
      echo 'Already tried to install RVM'
    else
      echo 'source /usr/local/rvm/scripts/rvm' >> ~/.bashrc
      curl -L https://get.rvm.io | sudo bash -s stable --autolibs=enabled --ruby=1.9.3
      source /usr/local/rvm/scripts/rvm
      sudo usermod -a -G rvm `whoami`
      sg rvm -c "source /usr/local/rvm/scripts/rvm && rvm install 1.9.3-p448 && rvm --default 1.9.3-p448"
      echo 'You need to logout and log back in...'
      exit
    fi
  }

function install_metasploit_deps(){
  sudo apt-get -y install \
    build-essential zlib1g zlib1g-dev \
    libxml2 libxml2-dev libxslt-dev locate \
    libreadline6-dev libcurl4-openssl-dev git-core \
    libssl-dev libyaml-dev openssl autoconf libtool \
    ncurses-dev bison curl wget postgresql \
    postgresql-contrib libpq-dev \
    libapr1 libaprutil1 libsvn1 \
    libpcap-dev > /dev/null
  install_rvm
  }
  
function configure_postgres(){
  if sudo grep -q 'host    "msf_database" "msf_user"      127.0.0.1/32          md5' /etc/postgresql/9.1/main/pg_hba.conf
    then
      echo "Already tried to configure database"
    else
      sudo cp /etc/postgresql/9.1/main/pg_hba.conf /etc/postgresql/9.1/main/pg_hba.conf.old
      sudo sed -i 's/host    all             all             127.0.0.1\/32            md5/host    "msf_database" "msf_user"      127.0.0.1\/32          md5\nhost     all            all            127.0.0.1\/32          ident/' /etc/postgresql/9.1/main/pg_hba.conf
      sudo -u postgres createuser -l -S -D -R msf_user
      sudo -u postgres psql -c "ALTER USER msf_user WITH PASSWORD 'no_password';"
      sudo -u postgres createdb --owner=msf_user msf_database
      sudo service postgresql restart
      cd ~/metasploit-framework
      cat > config/database.yml << EOF
production:
  adapter: postgresql
  database: msf_database
  username: msf_user
  password: no_password
  host: 127.0.0.1
  port: 5432
  pool: 75
  timeout: 5
EOF
      cat > ~/.msf4/msfconsole.rc << EOF
db_connect -y `pwd`/config/database.yml
workspace -a Workspace
EOF
    fi
  cd ~/work/bash-kali
  }

function install_metasploit(){
  cd ~/
  if [ ! -d "metasploit-framework" ]
    then
      install_metasploit_deps
      git clone https://github.com/rapid7/metasploit-framework.git
      echo "rvm use 1.9.3-p448@msf --create" > metasploit-framework/.rvmrc
      cd metasploit-framework
      gem install bundler
      bundle install
      configure_postgres
    else
      echo "Already tried to install metasploit"
  fi
  cd ~/work/bash-kali
  }

function install_rapid7(){
  install_w3af
  install_metasploit
  }
