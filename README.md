# Ansible Networking Vagrant Setup

This is an Ubuntu 14.04 based Vagrant machine for working with Ansible's
networking modules. It's not 16.04 as there are some issues with the 16.04
Vagrant image.

It is primarily for those network engineers who work in an enterprise
environment and have a Windows laptop. It provides a linux VM with Ansible
installed, as well as the following third party networking modules:

- [ntc-ansible](https://github.com/networktocode/ntc-ansible)
- [napalm-ansible](https://github.com/napalm-automation/napalm-ansible)

A shared folder is created within the Vagrant VM so you can edit playbooks on
your host and have them accessible by Ansible within the VM.

**Current Ansible version: 2.1.2.0**

I've only used this with Cisco devices, btw.

## Included Playbooks

The `provision.sh` script clones [my own repo](https://github.com/bordeltabernacle/ansible_network_automation_poc)
of Ansible playbooks, and then adds a symlink to the library of third party
modules. If you want to clone a different repo of Ansible playbooks, you can
change the following variables in the provision script:

```bash
GITHUB_USER=bordeltabernacle
PLAYBOOKS_DIR=ansible_network_automation_poc
```

Otherwise you can comment out the following lines of the script and start form scratch.

```bash
echo "Cloning & Symlinking $GITHUB_USER/$PLAYBOOKS_DIR..."
git clone https://github.com/$GITHUB_USER/$PLAYBOOKS_DIR.git /home/vagrant/shared/src > /dev/null 2>&1
ln -snf /home/vagrant/library /home/vagrant/shared/src/library > /dev/null 2>&1
```

## Debug Vagrantfile

The stdout and stderr from all the provision script commands are piped into
`/dev/null` for a quieter install. If you're having problems and you don't know
why, delete the ` > /dev/null 2>&1` from the `Vagrantfile` and you'll
get output from Vagrant in your terminal.

## Timezone

The timezone is set to `Europe/London` but can be changed within the
`Vagrantfile`

## Getting Started

I've written a blog post that may be helpful; [Using Vagrant to set up an Ansible Environment](http://bordeltabernacle.netlify.com/post/2016/08/using-vagrant-set-up-ansible-environment/)

### Install Virtualbox

You can get Virtualbox from [here](https://www.virtualbox.org/wiki/Downloads)

### Install Vagrant

You can get Vagrant from [here](https://www.vagrantup.com/downloads.html)

### With Git

If you have [Git](https://git-scm.com/) installed, clone this repository,
navigate into it via the command line, and `vagrant up`.

### Without Git

If you don't have [Git](https://git-scm.com/) installed, then you can download
this repository as a zip file, via the green `clone or download` button. Unzip
it into a directory of your choice, navigate into it via the command line, and `vagrant up`.

## Minimum Cisco Device Configuration

Ansible communicates with devices via SSH. On a Cisco switch or router the
following is the minimum configuration you need.

```
hostname {{ hostname }}

ip domain name {{ domain_name }}

username {{ username }} privilege 15 secret {{ secret }}

interface {{ interface }}
 ip address {{ ip_address }} {{ subnet_mask }}
 duplex auto
 speed auto

line vty 0 4
 login local
 transport input ssh

crypto key generate rsa
```

Also, `file prompt quiet` suppresses confirmation alerts during file operations.

## Known Issues

### Paramiko

Paramiko is pinned to a 1.x release as a backward incompatible change was
introduced with the release of version 2. [#15665](https://github.com/ansible/ansible/issues/15665)

### Vagrant Shared Folders

Ansible is not always able to save temporary files in Vagrant shared folders.
This disrupts many attributes of Ansible such as creating backup configuration
files. To get around this a `tmp` directory is created in the home directory and
files can be saved here and moved into the shared directory.

For instance, instead of saving the results of using the `template` module
within the shared folder, we can do this...

```yaml
    - name: Generate Configuration Files
      template:
        src: changes.cfg.j2
        dest: ../tmp/{{ ansible_host }}.cfg

    - name: Move Config into Configs Directory
      command: mv /home/vagrant/tmp/{{ ansible_host }}.cfg /home/vagrant/shared/configs
```

[#4386](https://github.com/ansible/ansible-modules-core/issues/4386)

## Contributing

Please open any Issues/PR's to improve this.
