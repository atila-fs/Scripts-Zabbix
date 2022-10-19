#!/bin/bash

for x in `cat jsoncrl.txt`
do
echo $x | sed 's/^/{"{#CRL}": "/' | sed 's/$/", "{#DESC}": "/' | sed 's/$/"},/'
done

