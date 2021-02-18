#!/bin/bash 

# This script demonstrates some basic usage of sort, uniq, and wc.

echo 'running sort /etc/passwd'

sort /etc/passwd

echo 'reverse the sort /etc/passwd'
sort -r /etc/passwd

echo 'sort based on UID i.e. 3 field in /etc/passwd'
echo 'using sort -n for numbers'
cut -d ':' -f 3 /etc/passwd | sort -n 


echo 'sort in reverse order with numbers using nr'
cut -d ':' -f 3 /etc/passwd | sort -nr


echo 'check disk usage using du for /var'
sudo du /var 

# first coloum result of du is in kb.

echo 'Sort the usage using'
sudo du /var | sort -n

echo 'Sort using the human readable form -h'
sudo du -h /var | sort -h

echo 'showing duplicate netstat ports'
netstat -nutl | grep ':' | awk '{print $4}' | awk -F ':' '{print $NF}' | sort -n

echo 'showing only unique ports using -un option in sort'
netstat -nutl | grep ':' | awk '{print $4}' | awk -F ':' '{print $NF}' | sort -nu

# sort and uniq is required to know the occurence of each item.

echo 'sort and uniq is required to know the occurence of each item.'

echo 'uniq can work only with sort'
netstat -nutl | grep ':' | awk '{print $4}' | awk -F ':' '{print $NF}' | sort  | uniq -c


echo 'use wc in /etc/passwd'
echo 'first output shows number of lines.'
echo 'second output shows number of words.'
echo 'third output shows number of characters.'

wc /etc/passwd

echo 'display the number of words in /etc/passwd'
wc -w /etc/passwd

echo 'display the number of characters in /etc/passwd'
wc -c /etc/passwd

echo 'display the number of lines in /etc/passwd'
wc -l /etc/passwd

echo 'grep command '-c' do display number of lines in /etc/passwd showing bash'
grep -c bash /etc/passwd

echo 'using simple grep and pipe to display the number of lines in /etc/passwd showing bash.'
grep bash /etc/passwd | wc -l

##
echo 'sorting using key i.e. -k'
echo 'sort based on the third field of /etc/passwd'
echo 'sort delimiter specifier using -t and -k using the field number'
cat /etc/passwd | sort -t ':' -k 3 -n

# usage of cut, sort and uniq.
# Analyse the webserver logs - 3 most visited urls.'

# Usage - sudo ./sort_uniq.sh /var/log/dpkg.log
echo 'Analyse logs, the 3 most hit log'
LOG_FILE="${1}"
# -e if exists
if [[ ! -e "${LOG_FILE}" ]]
then 
    echo "${LOG_FILE} does not exists."
fi

cut -d '"' -f 2 ${LOG_FILE} | sort | uniq -c | sort -n | tail -3 



