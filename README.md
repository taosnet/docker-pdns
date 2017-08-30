## Description

Provides easy access to a configurable, extensible, lightweight PowerDNS Authoritative Name Server. Currently supports SQLite backend but more could be added easily. Also provides support for enabling the REST API interface. Different configurations can easily be choosen through the use of environmental variables. SQLite backend is enabled by default.

By default, the server can be a slave for a domain. To disable slave mode, use **-e SLAVE=no** environmental variable. To enable master capabilities for the server, use **-e MASTER=yes**.

Configuration is stored in /etc/pdns if you choose to use a data volume for the configuration.

## Usage

To run a simple DNS server:
```
docker run --name mydns -d -p 53:53/udp -p 53:53/tcp taosnet/pdns_server
```

If you want to enable the REST API, specify the **APIKEY** environment variable with the value that you want your key to be.
```
docker run --name mydns -d -p 53:53/udp -p 53:53/tcp -p 8081:8081 -e APIKEY=MYAPIKEY -e WEBKEY=MYWEBKEY taosnet/pdns_server
```

If you want to use a data volume for changes with the SQLite backend:
```
docker run --name mydns -d -p 53:53/udp -p 53:53/tcp -v mydns-db:/etc/pdns/db taosnet/pdns_server
```

## Environmental Variables

* **APIKEY** is the key you wish to use to access the REST API on port 8081. If this variable is not specified, the REST API is disabled. Value cannot contain */*.
* **BACKEND** specifies the backend you wish to use. Defaults to sqlite. Currently supported backends are:
  * *sqlite* uses SQLite3 as the backend. Database is stored in */etc/pdns/db/zones.db*.
* **MASTER** enable the server to serve as the master for a zone.
* **SLAVE** enables the server to be a slave for a zone. Enabled by default, disable by setting to *no*.
* **SMTP** sets the default smtp redirector for the SOA record of new zones.
* **SOA_NAME** sets the default name for the SOA record of new zones.
* **WEBKEY** specifies a key to use for the Webserver. Not required, but **should** be specified if **APIKEY** is used.
