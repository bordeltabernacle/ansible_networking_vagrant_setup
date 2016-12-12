#!/bin/bash
# User Variables
LOCALE=en_GB.UTF-8
TIMEZONE=Europe/London
GITHUB_USER=bordeltabernacle
PLAYBOOKS_DIR=ansible_network_automation_poc
VAGRANT_HOME=/home/vagrant


echo "+-------------------------------------------------+"
echo "| Provisioning Ansible Networking Vagrant Machine |"
echo "+-------------------------------------------------+"

echo "Setting locale & timezone..."
sudo locale-gen $LOCALE
echo export LC_ALL=$LOCALE >> $VAGRANT_HOME/.profile
echo export TZ=$TIMEZONE >> $VAGRANT_HOME/.profile

echo "Creating tmp Directory..."
mkdir $VAGRANT_HOME/tmp

echo "Updating apt..."
sudo apt -y update

# echo "Installing Dependencies..."
# sudo apt-get -y install software-properties-common zlib1g-dev libxml2-dev libxslt-dev build-essential libssl-dev libffi-dev python-dev

# echo "Installing Git..."
# sudo apt-get -y install git

echo "Installing Pip"
sudo apt-get -y install python-pip
sudo -H pip install -U pip

# echo "Cloning $GITHUB_USER/$PLAYBOOKS_DIR..."
# sudo rm -r $VAGRANT_HOME/shared/src
# git clone https://github.com/$GITHUB_USER/$PLAYBOOKS_DIR.git $VAGRANT_HOME/shared/src

# echo "Installing $GITHUB_USER/$PLAYBOOKS_DIR requirements..."
# sudo -H pip install -r $VAGRANT_HOME/shared/src/requirements.txt

echo "+------------------------------------------------+"
echo "| Ansible Networking Vagrant Machine Provisioned |"
echo "+------------------------------------------------+"
echo "|                Go build stuff!                 |"
echo "+------------------------------------------------+"
