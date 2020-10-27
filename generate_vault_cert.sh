#!/usr/bin/env bash

if [[ -z $1 ]]; then
	echo "Must provide host cert to belong to"
	exit
fi

if [[ -z $VAULT_TOKEN ]]; then
	echo '$VAULT_TOKEN must be defined'
	exit
fi

if [[ -z $VAULT_ADDR ]]; then
	echo '$VAULT_ADDR must be defined'
	exit
fi

if [[ -z $DOMAIN ]]; then
	echo '$DOMAIN must be defined'
	exit
fi

CERT_HOST=$1

install -m 600 /dev/null "$CERT_HOST.json"

# if curl is successful, echo the resulting json filename so it can be piped into build_cert_files.sh
curl --silent \
	--header "X-Vault-Token: $VAULT_TOKEN" \
	--request POST \
	--data "common_name=$CERT_HOST" \
	"$VAULT_ADDR/v1/pki/issue/$DOMAIN" > "$CERT_HOST.json" && echo "$CERT_HOST.json"
