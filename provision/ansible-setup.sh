#!/bin/bash
TZ=Europe/London

echo "+-----------------------------------------+"
echo "| Provisioning Ansible Playground Machine |"
echo "+-----------------------------------------+"
echo "Setting timezone..."
sudo timedatectl set-timezone $TZ > /dev/null 2>&1
echo "Adding dependencies..."
sudo apt-get install software-properties-common > /dev/null 2>&1
echo "Adding Ansible repo..."
sudo apt-add-repository ppa:ansible/ansible > /dev/null 2>&1
echo "Updating apt-get..."
sudo apt-get -y update > /dev/null 2>&1
echo "Installing Ansible..."
sudo apt-get -y install ansible > /dev/null 2>&1
echo "+----------------------------------------+"
echo "| Ansible Playground Machine Provisioned |"
echo "+----------------------------------------+"
echo "|            Go build stuff!             |"
echo "+----------------------------------------+"
