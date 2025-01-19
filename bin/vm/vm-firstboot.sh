#!/usr/bin/env bash
set -eux

git clone https://github.com/johnko/homedir

mv homedir/.git ./

rm -fr homedir

git checkout .

cat <<EOS
# maybe disallow ubuntu from logging in
sudo usermod --expiredate 1 ubuntu
EOS
