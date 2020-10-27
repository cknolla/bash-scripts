#!/usr/bin/env bash

read -r CERT_FILE
if [[ -z $CERT_FILE ]]; then
        if [[ -z $1 ]]; then
                echo "Must provide filename containing cert response"
                exit
        else
                CERT_FILE=$1
        fi
fi

CERT_ROOT=${CERT_FILE%.*}  # strip .json extension from cert file

echo "Building $CERT_ROOT.pem..."
install -m 644 /dev/null "$CERT_ROOT.pem"
jq -r '.data.certificate' < "$CERT_FILE" > "$CERT_ROOT.pem"
jq -r '.data.ca_chain | join("\n")'  < "$CERT_FILE" >> "$CERT_ROOT.pem"

echo "Building $CERT_ROOT.key..."
install -m 600 /dev/null "$CERT_ROOT.key"
jq -r '.data.private_key' < "$CERT_FILE" > "$CERT_ROOT.key"
