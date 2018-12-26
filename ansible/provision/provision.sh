#!/bin/bash

HOST=hosts/local.ini
PLAYBOOK=provision.yaml
#ansible-playbook -i ${HOST} ${PLAYBOOK} -e @${CONFIG} -e ansible_ssh_user=ansible
ansible-playbook -i ${HOST} ${PLAYBOOK} -e ansible_ssh_user=ansible