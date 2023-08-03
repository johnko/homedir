#!/bin/bash
set -eux

ansible-playbook -i hosts playbook-status.yml
