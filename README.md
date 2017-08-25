## Description

Provides easy access to a configurable, extensible, lightweight PowerDNS Authoritative Name Server. Currently supports SQLite backend but more could be added easily. Also provides support for enabling the REST API interface. Different configurations can easily be choosen through the use of environmental variables. SQLite backend is enabled by default.

Configuration is stored in /etc/pdns if you choose to use a data volume for the configuration.

## Usage

To run a simple DNS server:
```
docker run --name mydns -d -p 53:53/udp -p 53:53/tcp taosnet/pdns
```

If you want to enable the REST API, specify the **APIKEY** environment variable with the value that you want your key to be.
```
docker run --name mydns -d -p 53:53/udp -p 53:53/tcp -p 8081:8081 -e APIKEY=MYAPIKEY taosnet/pdns
```

If you want to use a data volume for changes with the SQLite backend:
```
docker run --name mydns -d -p 53:53/udp -p 53:53/tcp -v mydns-db:/etc/pdns/db taosnet/pdns
```

## Environmental Variables

* **APIKEY** is the key you wish to use to access the REST API on port 8081. If this variable is not specified, the REST API is disabled.
* **BACKEND** specifies the backend you wish to use. Defaults to sqlite. Currently supported backends are:
  * *sqlite* uses SQLite3 as the backend. Database is stored in */etc/pdns/db/zones.db*.
