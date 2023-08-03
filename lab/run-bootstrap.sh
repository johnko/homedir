#!/bin/bash
set -eux

ansible-playbook -i hosts bootstrap.yml
