#!/bin/bash 

# Assignment create as shell script that requests an IP/Network address and then asks if the trafic from that
# IP/Network address should be accepted or dropped.

# The script should add the iptables rules that drop or accept traffic from the IP address the admin entered.

echo -n "Enter the IP/Network address"
read  address 
echo $address 

echo -n "Do you want the traffic should be accepted y/n"
read target_accept 
echo $target_accept

if [[ "${target_accept}" = "y" ]]
then 
	echo "target accept is y"
	iptables -A INPUT -s $address -j ACCEPT
else 
	echo "target accept is n"
	iptables -A INPUT -s $address -j DROP
fi