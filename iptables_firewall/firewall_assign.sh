#!/bin/bash


# iptables flush the chains for the filter table
iptables -t filter -F 


# challenge 1 
iptables -P  INPUT ACCEPT 
iptables -P OUTPUT ACCEPT


iptables  -P FORWARD DROP


# challenge 2 
iptables -t filter -nvL INPUT


# challenge 3
iptables -nvL -t nat 


# challenge 4
iptables -t filter -F 


# challenge 5 
iptables -t filter -A INPUT -p tcp --dport 22 -j DROP 

# challenge 6 

iptables -t filter -F 
iptables -t nat -F 
iptables -t mangle -F 
iptables -t raw -F 

iptables -P INPUT ACCEPT 
iptables -P OUTPUT ACCEPT 
iptables -P FORWARD ACCEPT