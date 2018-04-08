#!/bin/sh

route del default
# set default gateway to the router container
route add default gw 10.5.0.5
# LAN destinations that can connect to app services
if [ -z $LOCALNET ]; then
  LOCALNET="10.0.0.0/8 172.16.0.0/12 192.168.0.0/16"
fi
for NET in $LOCALNET; do
  route add -net $NET gateway 10.5.0.1
done

route del -net 10.5.0.0 netmask 255.255.0.0
#iptables -F
#iptables -t nat -F
#iptables -t nat -A PREROUTING -p tcp --dport 5000 -j DNAT --to-destination 10.5.0.6:5900
#iptables -t nat -A POSTROUTING -p tcp -d 10.5.0.6 --dport 5900 -j SNAT --to-source 192.168.99.1
#iptables -t nat -A POSTROUTING -j MASQUERADE

#ip rule add from 192.168.99.0/2 table 200
#ip route add default via 10.5.0.1 dev eth0 table 200
#ip rule add from 10.5.0.6  table 300
#ip route add default via 10.5.0.1 dev eth0 table 300

while [ 1 ];
  do
    sleep 3600
  done
