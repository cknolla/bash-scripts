#!/usr/bin/env bash

if [[ -z $1 ]]; then
	echo "Must provide FQDN for host to receive cert"
	exit
fi

FQDN=$1

openssl genrsa -out $FQDN.key 2048
openssl req -new -key $FQDN.key -out $FQDN.csr

cat > $FQDN.ext << EOF
authorityKeyIdentifier=keyid,issuer
basicConstraints=CA:FALSE
keyUsage = digitalSignature, nonRepudiation, keyEncipherment, dataEncipherment
subjectAltName = @alt_names
[alt_names]
DNS.1 = $FQDN
EOF

openssl x509 -req -in $FQDN.csr -CA kansaiCA.pem -CAkey kansaiCA.key -CAcreateserial -out $FQDN.crt -days 825 -sha256 -extfile $FQDN.ext

cat $FQDN.crt > $FQDN.pem
cat kansaiCA.pem >> $FQDN.pem

