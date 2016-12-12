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
sudo locale-gen $LOCALE > /dev/null 2>&1
echo export LC_ALL=$LOCALE >> $VAGRANT_HOME/.profile
echo export TZ=$TIMEZONE >> $VAGRANT_HOME/.profile

echo "Creating library & tmp Directories..."
mkdir $VAGRANT_HOME/tmp > /dev/null 2>&1

echo "Adding Ansible Repo..."
sudo apt-add-repository ppa:ansible/ansible > /dev/null 2>&1

echo "Updating apt-get..."
sudo apt-get -y update > /dev/null 2>&1

echo "Installing Dependencies..."
sudo apt-get -y install software-properties-common zlib1g-dev libxml2-dev libxslt-dev build-essential libssl-dev libffi-dev python-dev > /dev/null 2>&1

echo "Installing Git..."
sudo apt-get -y install git > /dev/null 2>&1

echo "Installing Ansible..."
sudo apt-get -y install ansible > /dev/null 2>&1

echo "Installing Pip"
sudo apt-get -y install python-pip > /dev/null 2>&1

echo "Installing NTC Ansible Module..."
sudo rm -r $VAGRANT_HOME/shared/ntc-ansible > /dev/null 2>&1
git clone https://github.com/networktocode/ntc-ansible --recursive $VAGRANT_HOME/shared/ntc-ansible > /dev/null 2>&1

echo "Installing Napalm Ansible Module..."
sudo rm -r $VAGRANT_HOME/shared/napalm-ansible > /dev/null 2>&1
git clone https://github.com/napalm-automation/napalm-ansible $VAGRANT_HOME/shared/napalm-ansible > /dev/null 2>&1

echo "Cloning $GITHUB_USER/$PLAYBOOKS_DIR..."
sudo rm -r $VAGRANT_HOME/shared/src > /dev/null 2>&1
git clone https://github.com/$GITHUB_USER/$PLAYBOOKS_DIR.git $VAGRANT_HOME/shared/src > /dev/null 2>&1

echo "Installing $GITHUB_USER/$PLAYBOOKS_DIR requirements..."
sudo -H pip install -r $VAGRANT_HOME/shared/src/requirements.txt > /dev/null 2>&1

echo "+------------------------------------------------+"
echo "| Ansible Networking Vagrant Machine Provisioned |"
echo "+------------------------------------------------+"
echo "|                Go build stuff!                 |"
echo "+------------------------------------------------+"
