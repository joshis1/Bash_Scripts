# Write the iptables commands that display the help for REJECT and LOG targets.

iptables -j REJECT --help

iptables -j LOG --help


# Write an iptables rule that REJECTS all incoming packets to port tcp/25 and sends back to the source a tcp-reset packet.

iptables -F INPUT
iptables -A INPUT  -p tcp --dport 25 -j REJECT --reject-with tcp-reset


# Write the iptables rules that log and then REJECT the headers of all incoming SSH (tcp/22) packets. 
# Prefix each log line with: ssh in:
# Generate incoming ssh traffic and display the logs. Filter the logs by log prefix.


iptables -F INPUT 
iptables -A INPUT -p tcp --dport 22 -j LOG  --log-prefix "Shreyas ssh in:" 
iptables -A INPUT -p tcp --dport 22 -j REJECT 

#Change the solution of Challenge #3 and LOG only the first packet of the connection (syn bit set). Deny all packets.

iptables -F INPUT 
iptables -A INPUT -p tcp --dport 22 --syn -j LOG  --log-prefix "Shreyas ssh in:" 
iptables -A INPUT -p tcp --dport 22 -j REJECT 


# Change the solution of Challenge #4 and LOG at most 1 packet per second. Deny all packets.

iptables -F INPUT 
iptables -A INPUT -p tcp --dport 22  --syn -m limit --limit 1/sec -j LOG  --log-prefix "Shreyas ssh in:" 
iptables -A INPUT -p tcp --dport 22 -j REJECT 


# Using the netstat command list all open ports and established connections (sockets)  
# of both TCP and UDP protocols both on Linux and Windows.

netstat -tupanl

#Using nmap scan ports 22,25,80 and 443 on 10.0.0.1 (replace it with an IP from you Network).

nmap -p 22,25,80,443  10.21.12.56

## nmap -p 22,25,80 10.21.12.56
# Starting Nmap 7.70 ( https://nmap.org ) at 2021-12-10 04:10 PST
# Nmap scan report for 10.21.12.56
# Host is up (0.0060s latency).

#PORT   STATE    SERVICE
#22/tcp filtered ssh
#25/tcp filtered smtp
#80/tcp open     http
#443/tcp filtered https

#Using nmap scan ports 22,25,80 and 443 and service versions on 10.0.0.1 (replace it with an IP from you Network).

# nmap -sV -p 22,25,80,443 10.21.12.56
Starting Nmap 7.70 ( https://nmap.org ) at 2021-12-10 04:14 PST
Nmap scan report for 10.21.12.56
Host is up (0.0074s latency).

PORT    STATE    SERVICE VERSION
22/tcp  filtered ssh
25/tcp  filtered smtp
80/tcp  open     http    lighttpd 1.4.53
443/tcp filtered https

#You want to mirror all TCP traffic that arrives at 10.0.0.10 to 10.0.0.1.
# What iptables rule on 10.0.0.10 accomplishes that?

#iptables -j TEE --help


iptables -F INPUT
iptables -A INPUT -p tcp --src 10.0.0.10 -j TEE  --gateway 10.0.0.1


# You want to redirect incoming TCP traffic to port 80 to port 8080 on the same host where a Proxy is running.
iptables -j REDIRECT --help


iptables -F nat 
iptables -t nat -A PREROUTING -p tcp --dport 80 -j REDIRECT  --to-ports 8080

iptables -t nat -vnL