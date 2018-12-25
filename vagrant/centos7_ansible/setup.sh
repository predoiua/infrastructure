#!/bin/sh

if [ "$1" != "/etc/sudoers.tmp" ]; then

    # This is the main script part

    sudo su
    mkdir -p ~/.ssh/
    touch ~/.ssh/authorized_keys
    echo $1 > ~/.ssh/authorized_keys

    # Create a ansible user. This user will:
    # - be used to do provisioning an thus, needs sudo rights
    echo "adding ansible user"
    useradd -m -d /home/ansible -s /bin/bash ansible
    mkdir -p /home/ansible/.ssh
    chmod 700 /home/ansible/.ssh
    touch /home/ansible/.ssh/authorized_keys
    echo $1 > /home/ansible/.ssh/authorized_keys
    chown -R ansible:ansible /home/ansible/.ssh

    sudo yum update -y

    # We first set this script as the EDITOR and then starts visudo.
    # Visudo will now start and use THIS SCRIPT as its editor
    export EDITOR=$0 && sudo -E visudo

else
    # Allow the 'ansible' user to complete 'sudo' actions without needing to enter a password
    # Normally we would use visudo to edit the sudo file, since we cannot edit the sudoers file directly
    # we will use a helper script to accomplish this

    # When visudo starts this script, it will provide the name of the sudoers
    # file as the first parameter and $1 will be non-empty. Because of that,
    # visudo will run this block.

    echo "Changing sudoers"

    # We change the sudoers file and then exit
    echo "ansible ALL=(ALL) NOPASSWD: ALL" >> $1
fi





