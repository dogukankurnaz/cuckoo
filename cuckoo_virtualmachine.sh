#!/bin/bash
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

echo -e "${BWHITE}*-----------------------------------------------------------------------------------------*"
echo -e "${BWHITE}                                      Downloading Win7 ISO                                 "
echo -e "${BWHITE}*-----------------------------------------------------------------------------------------*"
sudo wget --no-check-certificate https://cuckoo.sh/win7ultimate.iso

echo -e "${BWHITE}*------------------------------------------------------------------------------------------------------*"
echo -e "${BWHITE}                                       Mounting Win7 ISO                                                "
echo -e "${BWHITE}*------------------------------------------------------------------------------------------------------*"
sudo mkdir /mnt/win7
sudo chown cuckoo:cuckoo /mnt/win7/
sudo mount -o ro,loop win7ultimate.iso /mnt/win7

echo -e "${BWHITE}*------------------------------------------------------------------------------------------------------*"
echo -e "${BWHITE}                                       Setting Up Virtual Machine                                       "
echo -e "${BWHITE}*------------------------------------------------------------------------------------------------------*"

sudo apt-get -y install build-essential libssl-dev libffi-dev python-dev genisoimage
sudo apt-get -y install zlib1g-dev libjpeg-dev
sudo apt-get -y install python-pip python-virtualenv python-setuptools swig

pip install -U vmcloak

vmcloak-vboxnet0
sleep 4
vmcloak init --verbose --win7x64 win7x64base --cpus 2 --ramsize 2048
sleep 10
vmcloak clone win7x64base win7x64cuckoo
sleep 10
vmcloak list deps
sleep 10
vmcloak install win7x64cuckoo ie11
sleep 10
vmcloak snapshot --count 1 win7x64cuckoo 192.168.56.101
sleep 10
echo -e "${BWHITE}*------------------------------------------------------------------------------------------------------*"
echo -e "${BWHITE}                                       Process Completed Successfully!                                  "
echo -e "${BWHITE}*------------------------------------------------------------------------------------------------------*"