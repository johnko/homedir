#!/bin/bash
set -eux

ansible-playbook -i hosts status.yml
