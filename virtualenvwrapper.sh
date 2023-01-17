#!/bin/bash
BGREEN='\033[1;32m'

echo -e "${BWHITE}*------------------------------------------------------------------------------------------------------*"
echo -e "${BWHITE}                                       Upgrading and Updating the System                                "
echo -e "${BWHITE}                                              Installing virtualenv                                     "
echo -e "${BWHITE}*------------------------------------------------------------------------------------------------------*"
sudo apt-get update && sudo apt-get -y install virtualenv

echo -e "${BWHITE}*------------------------------------------------------------------------------------------------------*"
echo -e "${BWHITE}                                       Installing virtualenvwrapper                                     "
echo -e "${BWHITE}*------------------------------------------------------------------------------------------------------*"
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

echo -e "${BWHITE}*------------------------------------------------------------------------------------------------------*"
echo -e "${BGREEN}                                Process Completed Successfully!                                         "
echo -e "${BGREEN}                                Run the command source ~/.bashrc                                        "
echo -e "${BWHITE}*------------------------------------------------------------------------------------------------------*"