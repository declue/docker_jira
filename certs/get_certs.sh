rm *.pem
docker cp mymysql:/etc/certs/ca.pem .
docker cp mymysql:/etc/certs/client-cert.pem .
docker cp mymysql:/etc/certs/client-key.pem .
#mysql -u sqluser  --ssl-ca=ca.pem --ssl-cert=client-cert.pem --ssl-key=client-key.pem -h 172.17.0.1
