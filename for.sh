#!/usr/bin/env bash

echo $1
for i in {0..10..2}
do
	echo "$i" | sed 's/4/20/'
done
