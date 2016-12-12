#!/bin/bash

LOCALE=en_GB.UTF-8
TIMEZONE=Europe/London
VAGRANT_HOME=/home/vagrant


echo "+-------------------------------------------------+"
echo "| Provisioning Ansible Networking Vagrant Machine |"
echo "+-------------------------------------------------+"

echo "+------------------------------+"
echo "| Setting locale & timezone... |"
echo "+------------------------------+"
sudo locale-gen $LOCALE
echo export LC_ALL=$LOCALE >> $VAGRANT_HOME/.profile
echo export TZ=$TIMEZONE >> $VAGRANT_HOME/.profile

echo "+---------------------------+"
echo "| Creating tmp directory... |"
echo "+---------------------------+"
mkdir $VAGRANT_HOME/tmp

echo "+-----------------+"
echo "| Updating apt... |"
echo "+-----------------+"
sudo apt -y update

echo "+----------------------------+"
echo "| Installing dependencies... |"
echo "+----------------------------+"
sudo apt-get -y install libxml2-dev \
                        zlib1g-dev \
                        libxml2-dev \
                        libxslt-dev \
                        build-essential \
                        libssl-dev \
                        libffi-dev \
                        python-dev

echo "+--------------------------+"
echo "| Installing python-pip... |"
echo "+--------------------------+"
sudo apt-get -y install python-pip
sudo -H pip install -U pip

echo "+--------------------------------+"
echo "| Installing requirements.txt... |"
echo "+--------------------------------+"
sudo -H pip install -r $VAGRANT_HOME/shared/requirements.txt

echo "+------------------------------------------------+"
echo "| Ansible Networking Vagrant Machine Provisioned |"
echo "+------------------------------------------------+"
echo "|                Go build stuff!                 |"
echo "+------------------------------------------------+"
