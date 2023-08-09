#!/bin/bash
set -eux

ansible-playbook -i hosts.yml playbook-multipass.yml
