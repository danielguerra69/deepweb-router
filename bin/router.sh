#!/bin/sh

echo "nameserver 10.5.0.5" > /etc/resolv.conf
router-fw.sh
while [ 1 ];
  do
    sleep 3600
  done
