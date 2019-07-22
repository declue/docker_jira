#!/bin/bash

keytool -storepass changeit -noprompt -import -alias mysqlclientcertificate -file /etc/certs/client-cert.pem

exec "$@"
