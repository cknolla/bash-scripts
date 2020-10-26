#!/usr/bin/env bash

if [[ -z $1 ]]; then
	echo "Must supply host to ssh to" >&2
	exit
fi

ssh $1 "mkdir -p .ssh && chmod 700 .ssh/ && touch .ssh/authorized_keys && chmod 600 .ssh/authorized_keys && cat >> .ssh/authorized_keys" < ~/.ssh/id_rsa.pub
