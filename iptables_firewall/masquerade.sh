#!/bin/bash
 
##** LOAD BALANCE NAT TRAFFIC OVER 2 INTERNET CONNECTIONS WITH DYNAMIC IP ADDRESSES **##
 
# Traffic that goes over the first connection
# web: 80 443
# email: 25 465 143 993 110 995
# ssh: 22


ISP1="80 443 25 465 143 993 110 995 22"

# flushing the nat table and POSTROUTING chain

iptables -t nat -F POSTROUTING 

# enable routing 

echo "1" > /proc/sys/net/ipv4/ip_forward

for port in $ISP1
do 
	iptables -t nat -A POSTROUTING -p tcp --dport $port -o eth1 -j MASQUERADE

done

iptables -t nat -A POSTROUTING -o eth2 -j MASQUERADE 

