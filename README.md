# Ansible Networking Vagrant Setup

This is an Ubuntu 16.04 based Vagrant machine for working with Ansible's
networking modules. It uses the [bento Ubuntu box](https://atlas.hashicorp.com/bento/boxes/ubuntu-16.04) rather than the official Ubuntu box, for [this reason](https://github.com/mitchellh/vagrant/issues/7155#issuecomment-228568200).

It is primarily for those network engineers who work in an enterprise
environment and have a Windows laptop. It provides an easy to set up and use
linux VM with Ansible installed.

A shared folder is created within the Vagrant VM so you can edit playbooks on
your host and have them accessible by Ansible within the VM.

**Current Ansible version: 2.2.0.0**

I've only used this with Cisco devices, btw.

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

Also, `file prompt quiet` can be useful, as it suppresses confirmation alerts
during file operations.

## Third Party Libraries

This setup also includes Jason Edelman's `ntc-ansible` [module](https://github.com/networktocode/ntc-ansible). This is primarily to be able to use Cisco's `reboot in ` command. As this command prompts for confirmation, currently the ansible networking modules time out as they are not able to provide the required confirmation. Instead we can use the `ntc_reboot` module, like so:

```yaml
- name: Reload in 15 minutes
    ntc_reboot:
      platform: cisco_ios_ssh
      username: "{{ ansible_user }}"
      password: "{{ ansible_password }}"
      host: "{{ ansible_host }}"
      confirm: true
      timer: 15
```

This will reboot the device in 15 minutes, unless the `reload cancel` command is applied.

To use the `ntc-ansible` modules, they must be in the ansible library path. They are initially downloaded the the Vagrant user's home directory. There are a few options here:

1. Move the library directory into the root of the playbooks directory:

    ```
    mv /home/vagrant/ntc-ansible/library /home/vagrant/shared/playbooks_dir
    ```

2. Set up a symlink to the ntc-ansible library:

    ```
    ln -sn /home/vagrant/ntc-ansible/library /home/vagrant/shared/playbooks_dir/library
    ```

3. Add a line to the `ansible.cfg` file pointing to the ntc-ansible library:

    ```
    [defaults]
    library = ../../ntc-ansible/library
    ```

## Known Issues

### Paramiko

Paramiko is currently version 2.1.1

Paramiko was previously pinned to a 2.0.2 release due to [this issue](https://github.com/paramiko/paramiko/issues/859)

Paramiko was previously pinned to a 1.17 release as a backward incompatible change was
introduced with the release of version 2, issue [#15665](https://github.com/ansible/ansible/issues/15665). If you are having issues, then do try downgrading your paramiko version:

```
sudo -H pip install paramiko==1.17
```

### Vagrant Shared Folders

Ansible is not always able to save temporary files in Vagrant shared folders. Issue [#4386](https://github.com/ansible/ansible-modules-core/issues/4386).
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

## Contributing

Please open any Issues/PR's to improve this.
