#!/bin/sh

rm -f localhost.direct.zip
wget https://aka.re/localhost -O localhost.direct.zip

rm -f localhost.direct.crt localhost.direct.key
unzip -P localhost localhost.direct.zip

rm -f localhost.direct.zip

echo done
