#!/bin/sh

# Initial setup
if ! [ -e /etc/pdns/conf.d/backend.conf ]; then
	if [ -n "$BACKEND" ]; then
		if [ "$BACKEND" = "sqlite" ]; then
			mv /etc/pdns/default.conf.d/sqlite.conf /etc/pdns/conf.d/backend.conf
			chown -R pdns.pdns /etc/pdns/db
		fi
	fi
	if [ -n "$APIKEY" ]; then
		sed "s/DNSAPIS3rv3r/$APIKEY/" /etc/pdns/default.conf.d/api.conf >/etc/pdns/conf.d/api.conf
		if [ -n "$WEBKEY" ]; then
			sed -i "s/DNSW3bP4ssword/$WEBKEY/" /etc/pdns/conf.d/api.conf
		fi
	fi
	if [ -n "$MASTER" ] && [ "$MASTER" = "yes" ]; then
		mv /etc/pdns/default.conf.d/master.conf /etc/pdns/conf.d/master.conf
	fi
	# Defaults to slave mode
	if [ -z "$SLAVE" ] || [ "$SLAVE" = "yes" ]; then
		mv /etc/pdns/default.conf.d/slave.conf /etc/pdns/conf.d/slave.conf
	fi
	if [ -n "$SMTP" ]; then
		sed "s/default-soa-mail=DIRECTOR/default-soa-mail=$SMTP/" </etc/pdns/default.conf.d/soa.conf >/etc/pdns/conf.d/soa.conf
	fi
	if [ -n "$SOA_NAME" ]; then
		echo "default-soa-name=$SOA_NAME" >>/etc/pdns/conf.d/soa.conf
	fi
fi

if ! [ -e /etc/pdns/conf.d/backend.conf ]; then
	echo Must specify a backend to use!
	exit 1
fi

/usr/sbin/pdns_server --config-dir=/etc/pdns
