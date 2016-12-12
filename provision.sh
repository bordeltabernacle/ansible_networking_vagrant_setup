#!/bin/bash
# User Variables
LOCALE=en_GB.UTF-8
TIMEZONE=Europe/London
VAGRANT_HOME=/home/vagrant
USER_PLAYBOOK=true
GITHUB_USER=bordeltabernacle
PLAYBOOKS_DIR=ansible_network_automation_poc


echo "+-------------------------------------------------+"
echo "| Provisioning Ansible Networking Vagrant Machine |"
echo "+-------------------------------------------------+"

echo "+-------------------------------+"
echo "| Setting locale & timezone..." |
echo "+-------------------------------+"
sudo locale-gen $LOCALE
echo export LC_ALL=$LOCALE >> $VAGRANT_HOME/.profile
echo export TZ=$TIMEZONE >> $VAGRANT_HOME/.profile

echo "+----------------------------+"
echo "| Creating tmp directory..." |
echo "+----------------------------+"
mkdir $VAGRANT_HOME/tmp

echo "+------------------+"
echo "| Updating apt..." |
echo "+------------------+"
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

echo "+---------------------------+"
echo "| Installing python-pip..." |
echo "+---------------------------+"
sudo apt-get -y install python-pip
sudo -H pip install -U pip

echo "+---------------------------------+"
echo "| Installing requirements.txt..." |
echo "+---------------------------------+"
sudo -H pip install -r $VAGRANT_HOME/shared/requirements.txt

if [ "$USER_PLAYBOOK" = true ] ; then
    echo "+-----------------------------------------+"
    echo "| Cloning $GITHUB_USER/$PLAYBOOKS_DIR..." |
    echo "+-----------------------------------------+"
    cd $VAGRANT_HOME/shared
    git clone https://github.com/$GITHUB_USER/$PLAYBOOKS_DIR.git
fi

if [ -f "$VAGRANT_HOME/shared/$PLAYBOOKS_DIR/requirements.txt" ] ; then
    echo "+-----------------------------------------------+"
	echo "| Installing playbooks pip requirements file... |"
    echo "+-----------------------------------------------+"
    sudo -H pip install -r $VAGRANT_HOME/shared/$PLAYBOOKS_DIR/requirements.txt
else
    echo "+-------------------------------------------------------------+"
	echo "| No $GITHUB_USER/$PLAYBOOKS_DIR pip requirements file found. |"
    echo "+-------------------------------------------------------------+"
fi

echo "+------------------------------------------------+"
echo "| Ansible Networking Vagrant Machine Provisioned |"
echo "+------------------------------------------------+"
echo "|                Go build stuff!                 |"
echo "+------------------------------------------------+"
