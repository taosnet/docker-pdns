#!/bin/sh

echo 'daemon=no
local-port=53
local-address=0.0.0.0' >/etc/pdns/recursor.conf
if [ -n "$ALLOW" ]; then
	echo "allow-from=127.0.0.0/8,$ALLOW" >>/etc/pdns/recursor.conf
fi
if [ -n "$FORWARD" ]; then
	echo "forward-zones=$FORWARD" >>/etc/pdns/recursor.conf
fi
if [ -n "$APIKEY" ]; then
	echo "api-key=$APIKEY" >>/etc/pdns/recursor.conf
fi
if [ -n "$WEBKEY" ]; then
	echo "webserver=yes" >>/etc/pdns/recursor.conf
	echo "webserver-password=$WEBKEY" >>/etc/pdns/recursor.conf
	echo "webserver-address=0.0.0.0" >>/etc/pdns/recursor.conf
	echo "webserver-port=8081" >>/etc/pdns/recursor.conf
	if [ -n "$WEBFROM" ]; then
		echo "webserver-allow-from=$WEBFROM" >>/etc/pdns/recursor.conf
	fi
fi
/usr/sbin/pdns_recursor
