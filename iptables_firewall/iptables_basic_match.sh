#!/bin/bash
iptables -F
iptables -A INPUT -s 100.0.0.1 -j DROP 
iptables -A INPUT -s 1.2.3.4 -j DROP 
iptables -A OUTPUT -d 80.0.0.1 -j DROP  


iptables -F 
iptables -A FORWARD -p tcp -m multiport --dports 80,443 -d www.linuxquestions.org -j DROP


iptables -F 
iptables -I INPUT -s 27.103.0.0/16 -j DROP 

#Write an iptables rule in order to drop all UDP packets to port 53 (DNS) 
# if they are destined to another IP address (not to 8.8.8.8). The Linux Machine is the Router.


iptables -F 
iptables -A FORWARD ! -d 8.8.8.8 -p udp --dport 53 -j DROP


#Write the iptables rules that allow all traffic of the loopback (lo) interface.

iptables -F 

iptables -A INPUT -i lo -j ACCEPT 
iptables -A OUTPUT -o lo -j ACCEPT 


# Your Linux Machine is the router. The internal interface is called eth0 and the external interface is called eth1.

# Write the iptables rules that allow establishing incoming ssh (tcp/22) connections only from the LAN.

iptables -F 
iptables -A FORWARD -i etho -p tcp --dport 22 --syn -j ACCEPT
iptables -A FORWARD -i eth1 -p tcp --dport 22 --syn -j DROP 


# Create a firewall script for your Laptop what runs Linux. 
# All outgoing traffic is allowed but only the return incoming traffic is permitted. 
# No services are running on the laptop.

# Consider Challenge #2. Make sure that you also:

# - allow the loopback interface traffic (lo)

# - drop invalid packets

# - flush the firewall at the beginning of the script

iptables -F 
iptables -A INPUT -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT 
iptables -A INPUT -m state --state INVALID -j DROP 
iptables -A OUTPUT -m state --state INVALID -j DROP 
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -A OUTPUT -m state --state NEW,ESTABLISHED,RELATED -j ACCEPT


#You start the SSH Daemon on your laptop and want to allow incoming SSH connections (tcp/22) 
# only from your work (IP address: 100.0.0.1).

iptables -F 
iptables -A INPUT -p tcp --dport 22 ! -s 100.0.0.1 -j DROP 


# check the outcome.
iptables -vnL 

# The MAC Address of the LAN Router is b4:6d:83:77:85:f5

# Write a single iptables rule that allows the communication of your Linux host only with the router. 
# It cannot communicate with other hosts inside the same LAN. Do not modify the policy.

iptables -A INPUT  -m mac ! --mac-source b4:6d:83:77:85:f5 -j DROP  

# You have a LAN with a server and 5 hosts. 
# The MAC addresses of the hosts are: b4:6d:83:77:85:f1 b4:6d:83:77:85:f2 b4:6d:83:77:85:f3 b4:6d:83:77:85:f4 b4:6d:83:77:85:f5
# Write an iptables script on the server that allows only the communication with those 5 hosts. 
# No other host is allowed to communicate with the server.

iptables -F 

HOST_MAC_ADDRESSES="b4:6d:83:77:85:f1 b4:6d:83:77:85:f2 b4:6d:83:77:85:f3 b4:6d:83:77:85:f4 b4:6d:83:77:85:f5"
for MAC_ADDRESS in $HOST_MAC_ADDRESSES
do 
	iptables -A INPUT -m mac --mac-source $MAC_ADDRESS -j ACCEPT
	echo "$MAC_ADDRESS Allowed"
done
iptables -P INPUT DROP


# Write the iptables rules that permit outgoing web traffic (tcp ports 80 and 443) only between 10:00 and 18:00 UTC.

iptables -F 
iptables -A OUTPUT -p tcp -m multiport --dports 80,443 -m time  --timestart 10:00 --timestop 18:00 -j ACCEPT 
iptables -A OUTPUT -p tcp -m multiport --dports 80,443 -j  DROP 


# Consider Challenge #7. Add a match to allow web traffic only on the weekend between 10:00 and 18:00 UTC.

#iptables -m time --help 

iptables -F 
iptables -A OUTPUT -p tcp -m multiport --dports 80,443 \
 -m time --timestart 10:00 --timestop 18:00 --weekdays Sat,Sun -j ACCEPT 
iptables -A OUTPUT -p tcp -m multiport --dports 80,443 -j  DROP

# Write the iptables rules that permit only 2 incoming ICMP echo-request (ping) packets per second from any IP address.

# iptables -m limit --help

iptables -F 
iptables -A INPUT -p icmp -m limit --limit 2/sec -j ACCEPT
iptables -A INPUT -p icmp -j DROP

# Write an iptables rule that permits only 10 NEW TCP connections from the same IP address.

# iptables -m connlimit --help

iptables -F 
iptables -A INPUT -p tcp --syn -m connlimit --connlimit-above 10  -j DROP 



