#!/bin/sh

# Initial setup
if ! [ -e /etc/pdns/conf.d/backend.conf ]; then
	if [ -n "$BACKEND" ]; then
		if [ "$BACKEND" = "sqlite" ]; then
			mv /etc/pdns/conf.d/default.conf.d/sqlite.conf /etc/pdns/conf.d/backend.conf
		fi
	fi
	if [ -n "$APIKEY" ]; then
		sed "s/DNSAPIS3rv3r/$APIKEY/" /etc/pdns/default.conf.d/api.conf >/etc/pdns/conf.d/api.conf
		if [ -n "$WEBKEY" ]; then
			sed -i "s/DNSW3bP4ssword/$WEBKEY/" /etc/pdns/conf.d/api.conf
		fi
	fi
fi

if ! [ -e /etc/pdns/conf.d/backend.conf ]; then
	echo Must specify a backend to use!
	exit 1
fi

/usr/sbin/pdns_server
