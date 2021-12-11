#!/bin/bash
iptables -F
iptables -A INPUT -s 100.0.0.1 -j DROP 
iptables -A INPUT -s 1.2.3.4 -j DROP 
iptables -A OUTPUT -d 80.0.0.1 -j DROP  


iptables -F 
iptables -A OUTPUT -p tcp -m multiport --dports 80,443 -d www.linuxquestions.org -j DROP


