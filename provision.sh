#!/bin/bash
TIMEZONE=Europe/London
LOCALE=en_GB.UTF-8

echo "+-------------------------------------------------+"
echo "| Provisioning Ansible Networking Vagrant Machine |"
echo "+-------------------------------------------------+"

echo "Setting timezone..."
sudo locale-gen $LOCALE
echo export TZ=$TIMEZONE >> /home/vagrant/.profile

echo "Creating non-shared tmp directory..."
mkdir /home/vagrant/tmp > /dev/null 2>&1

echo "Installing dependencies..."
sudo apt-get -y install software-properties-common zlib1g-dev libxml2-dev libxslt-dev build-essential libssl-dev libffi-dev python-dev > /dev/null 2>&1

echo "Adding Ansible repo..."
sudo apt-add-repository ppa:ansible/ansible > /dev/null 2>&1

echo "Updating apt-get..."
sudo apt-get -y update > /dev/null 2>&1

echo "Installing Git..."
sudo apt-get -y install git > /dev/null 2>&1

echo "Installing Ansible..."
sudo apt-get -y install ansible > /dev/null 2>&1

echo "Installing pip & requirements"
sudo apt-get -y install python-pip > /dev/null 2>&1
sudo pip install -r /home/vagrant/shared/requirements.txt > /dev/null 2>&1

echo "Installing ntc-ansible module..."
git clone https://github.com/networktocode/ntc-ansible --recursive > /dev/null 2>&1
sudo rm -r /home/vagrant/shared/library > /dev/null 2>&1
sudo mv /home/vagrant/ntc-ansible/library /home/vagrant/shared/library > /dev/null 2>&1

echo "Installing napalm-ansible module..."
git clone https://github.com/napalm-automation/napalm-ansible > /dev/null 2>&1
sudo mv /home/vagrant/napalm-ansible/library/* /home/vagrant/shared/library/ > /dev/null 2>&1

echo "+------------------------------------------------+"
echo "| Ansible Networking Vagrant Machine Provisioned |"
echo "+------------------------------------------------+"
echo "|                 Go build stuff!                |"
echo "+------------------------------------------------+"
