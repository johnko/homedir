#!/bin/bash
set -eux

git clone https://github.com/johnko/homedir

mv homedir/.git ./

rm -fr homedir

git checkout .
