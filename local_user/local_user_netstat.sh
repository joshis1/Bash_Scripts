#!/bin/bash

# netstat to show open ports.

# netstat -n -> to show port numbers.

# netstat -nu -> to show port number with udp.

# netstat -nut -> to show port number with udp and tcp.

# netstat -nutl -> to show port number with udp, tcp and listening port.

# install netstat
# apt install net-tools.

netstat -nutl | grep ':' | awk '{print $4}' | awk -F ':' '{print $NF}'

# -p - pid of the program. 
netstat -4nutlp | grep 962 

