#!/bin/bash
LOCALE=en_GB.UTF-8
TIMEZONE=Europe/London
GITHUB_USER=bordeltabernacle
PLAYBOOKS_DIR=ansible_network_automation_poc

echo "+-------------------------------------------------+"
echo "| Provisioning Ansible Networking Vagrant Machine |"
echo "+-------------------------------------------------+"

echo "Setting locale & timezone..."
sudo locale-gen $LOCALE > /dev/null 2>&1
echo export LC_ALL=$LOCALE >> /home/vagrant/.profile
echo export TZ=$TIMEZONE >> /home/vagrant/.profile

echo "Creating library & tmp Directories..."
mkdir /home/vagrant/library > /dev/null 2>&1
mkdir /home/vagrant/tmp > /dev/null 2>&1

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

echo "Installing Pip & Requirements"
sudo apt-get -y install python-pip > /dev/null 2>&1
sudo pip install -r /home/vagrant/requirements.txt > /dev/null 2>&1

echo "Installing NTC Ansible Module..."
git clone https://github.com/networktocode/ntc-ansible --recursive > /dev/null 2>&1
sudo mv /home/vagrant/ntc-ansible/library/* /home/vagrant/library/ > /dev/null 2>&1

echo "Installing Napalm Ansible Module..."
git clone https://github.com/napalm-automation/napalm-ansible > /dev/null 2>&1
sudo mv /home/vagrant/napalm-ansible/library/* /home/vagrant/library/ > /dev/null 2>&1

echo "Cloning & Symlinking $GITHUB_USER/$PLAYBOOKS_DIR..."
git clone https://github.com/$GITHUB_USER/$PLAYBOOKS_DIR.git /home/vagrant/shared/src > /dev/null 2>&1
ln -snf /home/vagrant/library /home/vagrant/shared/src/library > /dev/null 2>&1

echo "+------------------------------------------------+"
echo "| Ansible Networking Vagrant Machine Provisioned |"
echo "+------------------------------------------------+"
echo "|                 Go build stuff!                |"
echo "+------------------------------------------------+"
