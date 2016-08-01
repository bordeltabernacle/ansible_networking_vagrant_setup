#!/bin/bash
TZ=Europe/London

echo "+-----------------------------------------------+"
echo "| Provisioning Ansible Cisco Playground Machine |"
echo "+-----------------------------------------------+"
echo "Setting timezone..."
sudo timedatectl set-timezone $TZ > /dev/null 2>&1
echo "Adding dependencies..."
sudo apt-get install software-properties-common > /dev/null 2>&1
echo "Adding Ansible repo..."
sudo apt-add-repository ppa:ansible/ansible > /dev/null 2>&1
echo "Updating apt-get..."
sudo apt-get -y update > /dev/null 2>&1
echo "Installing Git..."
sudo apt-get -y install git > /dev/null 2>&1
echo "Installing Ansible..."
sudo apt-get -y install ansible > /dev/null 2>&1
echo "Installing ntc-ansible module..."
sudo apt-get -y install python-pip > /dev/null 2>&1
sudo apt-get -y install zlib1g-dev libxml2-dev libxslt-dev python-dev > /dev/null 2>&1
sudo pip install ntc-ansible > /dev/null 2>&1
git clone https://github.com/networktocode/ntc-ansible --recursive > /dev/null 2>&1
sudo rm -r /home/vagrant/shared/library > /dev/null 2>&1
sudo mv /home/vagrant/ntc-ansible/library /home/vagrant/shared/library > /dev/null 2>&1
echo "+----------------------------------------------+"
echo "| Ansible Cisco Playground Machine Provisioned |"
echo "+----------------------------------------------+"
echo "|                Go build stuff!               |"
echo "+----------------------------------------------+"
