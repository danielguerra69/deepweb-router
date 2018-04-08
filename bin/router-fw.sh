#!/bin/sh

WAN="eth1"
LAN="eth0"

# Tor's TransPort
_trans_port="9040"

#
# Flush Rules
iptables -F
iptables -t nat -F
iptables -t mangle -F
iptables -X

#
# Default to drop packets
iptables -P INPUT DROP
iptables -P OUTPUT DROP
iptables -P FORWARD DROP

#
# Allow all local loopback traffic
iptables -A INPUT -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT

#
# Allow output on $WAN and $LAN if. Allow input on $LAN if.
iptables -A INPUT -i $LAN -j ACCEPT
iptables -A OUTPUT -o $WAN -j ACCEPT
iptables -A OUTPUT -o $LAN -j ACCEPT

# tor socks5 redirect
iptables -t nat -A PREROUTING -i $LAN -p tcp --dport 9050 -j REDIRECT --to-ports 9050
# tor dns redirect
iptables -t nat -A PREROUTING -i $LAN -p udp --dport 53 -j REDIRECT --to-ports 53

# udp to i2p
iptables -t nat -A PREROUTING -i $_inc_if -p udp -j REDIRECT --to-ports 7655

# i2p web console
iptables -t nat -A PREROUTING -i $LAN -p tcp --dport 7070 -j REDIRECT --to-ports 7070
# i2p http proxy
iptables -t nat -A PREROUTING -i $LAN -p tcp --dport 4444 -j REDIRECT --to-ports 4444
# tcp traffic to tor
iptables -t nat -A PREROUTING -i $LAN -p tcp --syn -j REDIRECT --to-ports $_trans_port

iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

iptables -A FORWARD -o $LAN -m state --state ESTABLISHED,RELATED -j ACCEPT

iptables -A FORWARD -i $LAN -o $WAN -j ACCEPT
iptables -t nat -A POSTROUTING -o $WAN -j MASQUERADE

exit 0 #report success
