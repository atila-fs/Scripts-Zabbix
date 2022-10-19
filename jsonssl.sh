#!/bin/bash

for x in `cat jsonssl.txt`
do
echo $x | sed 's/^/"{"{#DOMAIN}":"/' | sed 's/$/"},/'
done


