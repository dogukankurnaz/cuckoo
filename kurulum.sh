#!/bin/bash
clear
RED='\e[1;91m'
BLUE='\033[0;34m'
BRED='\033[1;31m' 
PURPLE='\033[0;35m'
WHITE='\033[0;37m'
BCYAN='\033[1;36m'
YELLOW='\033[0;33m'
BWHITE='\033[1;37m'
BGREEN='\033[1;32m'
RESET='\033[0m'
VER='0.1'
user=$(whoami)
date=$(date "+%D Time: %I:%M %p")

# Banner
banner(){
cat<<"EOF"
         _nnnn_                      
        dGGGGMMb     ,"""""""""""""""""""""""""""""""""""""".
       @p~qp~~qMb    |             Cuckoo Install           |
       M|@||@) M|   _;......................................'
       @,----.JM| -'
      JS^\__/  qKL
     dZP        qKRb
    dZP          qKKb
   fZP            SMMb
   HZM            MMMM
   FqM            MMMM
 __| ".        |\dS"qML
 |    `.       | `' \Zq
_)      \.___.,|     .'
\____   )MMMMMM|   .'
     `-'       `--' dogukaN
EOF
echo ""
echo -e "${YELLOW}+ -- --=[Date: $date"
echo -e "${RED}+ -- --=[Welcome $user :)"
echo -e "${BLUE}+ -- --=[Cuckoo Sandbox Installer v$VER by @dogukankurnaz"
echo -e "${PURPLE}+ -- --=[https://github.com/dogukankurnaz"
echo -e "${RESET}"
}
banner

echo -e "${RED}Upgrading and Updating the System"
sudo apt update
sudo apt upgrade -y

echo -e "${RED}Required Package Installations"
sudo apt-get install python python-pip python-dev libffi-dev libssl-dev -y
sudo apt-get install python-virtualenv python-setuptools -y
sudo apt-get install libjpeg-dev zlib1g-dev swig -y
sudo apt-get install mongodb -y
sudo apt-get install postgresql libpq-dev -y
sudo apt install virtualbox -y
sudo apt-get install tcpdump apparmor-utils -y


echo -e "${RED}TCPDUMP Installations"
sudo groupadd pcap
sudo usermod -a -G pcap cuckoo
sudo chgrp pcap /usr/sbin/tcpdump
sudo setcap cap_net_raw,cap_net_admin=eip /usr/sbin/tcpdump
getcap /usr/sbin/tcpdump
sudo aa-disable /usr/sbin/tcpdump
sudo usermod -a -G vboxusers cuckoo
sudo su cuckoo

echo -e "${RED}Installing Crypto Libraries"
sudo apt-get install swig
sudo pip install m2crypto

echo -e "${RED}Installing virtual environment wrapper"
sudo apt-get update && sudo apt-get -y install virtualenv

sudo apt-get -y install virtualenvwrapper

echo "source /usr/share/virtualenvwrapper/virtualenvwrapper.sh" >> ~/.bashrc

sudo apt-get -y install python3-pip

pip3 completion --bash >> ~/.bashrc

pip3 install --user virtualenvwrapper

echo "export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3" >> ~/.bashrc

echo "source ~/.local/bin/virtualenvwrapper.sh" >> ~/.bashrc

export WORKON_HOME=~/.virtualenvs

echo "export WORKON_HOME=~/.virtualenvs" >> ~/.bashrc

echo "export PIP_VIRTUALENV_BASE=~/.virtualenvs" >> ~/.bashrc 

echo -e "${YELLOW}Process Completed Successfully!"