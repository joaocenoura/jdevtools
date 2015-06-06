#!/bin/bash

BASE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/" && pwd )"

export PYTHONUNBUFFERED=1
export ANSIBLE_FORCE_COLOR=true
export ANSIBLE_HOST_KEY_CHECKING=false
export ANSIBLE_SSH_ARGS='-o UserKnownHostsFile=/dev/null -o ControlMaster=auto -o ControlPersist=60s'

ansible-playbook \
	--private-key=${BASE_DIR}/.vagrant/machines/default/virtualbox/private_key \
	--user=vagrant \
	--connection=ssh \
	--limit=default \
	--inventory-file=${BASE_DIR}/.vagrant/provisioners/ansible/inventory provisioning/playbook.yml \
	--tags "backup"
