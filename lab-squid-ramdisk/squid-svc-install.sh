#!/bin/sh

set -e

install -d -m 755 -o root /usr/local/bin
install -m 755 -o root start.sh /usr/local/bin/start.sh

install -m 644 -o root openssl.cnf.add /etc/ssl/openssl.cnf.add
cat /etc/ssl/openssl.cnf.add >> /etc/ssl/openssl.cnf

install -d -m 755 -o root /squid
install -m 644 -o root squid.conf /squid/squid.conf
