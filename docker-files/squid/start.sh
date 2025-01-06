#!/bin/sh

set -e

CHOWN=$(/usr/bin/which chown)
SQUID=$(/usr/bin/which squid)
SQUIDCONF=/squid/squid.conf

prepare_folders() {
	echo "Preparing folders..."
	mkdir -p /squid/certs /squid/cache /squid/logs /squid/coredump
	"$CHOWN" -R squid:squid /squid
}

initialize_cache() {
	echo "Creating cache folder..."
	rm /var/run/squid.pid || true
	"$SQUID" -f ${SQUIDCONF} --foreground -z
	# /var/run/squid.pid
	# sleep 10
	echo "Cache folders created."
}

create_cert() {
	if [ ! -f /squid/certs/private.pem ]; then
		echo "Creating certificate..."
		openssl req -new -newkey rsa:2048 -sha256 -days 3650 -nodes -x509 \
			-extensions v3_ca -keyout /squid/certs/private.pem \
			-out /squid/certs/private.pem \
			-subj "/CN=$CN/O=$O/OU=$OU/C=$C" -utf8 -nameopt multiline,utf8

		openssl x509 -in /squid/certs/private.pem \
			-outform DER -out /squid/certs/CA.der

		openssl x509 -inform DER -in /squid/certs/CA.der \
			-out /squid/certs/CA.pem
	else
		echo "Certificate found..."
	fi
}

clear_certs_db() {
	echo "Clearing generated certificate db..."
	rm -rfv /squid/ssl_db/
	/usr/lib/squid/security_file_certgen -d -c -s /squid/ssl_db/ -M 4MB
	"$CHOWN" -R squid.squid /squid/ssl_db
}

run() {
	echo "Starting squid..."
	prepare_folders
	create_cert
	clear_certs_db
	initialize_cache
	exec "$SQUID" -f ${SQUIDCONF} -NYCd 1
}

run
