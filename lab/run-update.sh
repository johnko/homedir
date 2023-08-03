#!/bin/bash
set -eux

ansible-playbook -i hosts --ask-become-pass update.yml
