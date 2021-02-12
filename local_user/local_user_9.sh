#!/bin/bash

# This script demonstrates Redirecting I/O i.e. Input and Output using File Descriptor.

# FD 0 - STDIN
# FD 1 - STDOUT
# FD 2 - STDERR

# In Linux, everything is a file.

read X < /etc/host.conf
echo ${X}

# 0< means STDIN -- i.e. redirecting to STDIN
read X 0< /etc/host.conf
echo ${X}

# 1> means STDOUT -- i.e. redirecting to STDOUT
echo "${UID}" 1> uid

# man head 

# Here the STDERR i.e. unable to open /fakefile wasn't recorded into head.out
head -n1 /etc/passwd /etc/hosts /fakefile > head.out

# Here the STDERR is directed to the file head.err
head -n1 /etc/passwd /etc/hosts /fakefile 2> head.err

# Redirect STDERR to STDOUT
head -n1 /etc/passwd /etc/hosts /fakefile 2>&1

# &1 - 1 means STDOUT - File descriptor value

# Re-direct both stdout and stderr.
# Here the HEAD STDOUT is redirecting to head.both.
# Next the STDERR i.e. 2 is redirecting to STDOUT i.e. 1

head -n1 /etc/passwd /etc/hosts /fakefile > head.both 2>&1

# A simple and new way to redirect both STDOUT and STDERR is 
head -n1 /etc/passwd /etc/hosts /fakefile &> head1.both

# Appending to the file - STDOUT and STDERR.
head -n1 /etc/passwd /etc/hosts /fakefile &>> headAppend.both

# STDERR is not passed through the pipe.
# How to pass the STDERR through the pipe.
head -n1 /etc/passwd /etc/hosts /fakefile 2>&1 | cat -n 

# Redirect STDIN to a program, using FD 0.
read LINE 0< head.err
echo 
echo "Contents of head.err:"
cat head.err

# Redirect STDOUT to a file using FD 1, overwriting the file.
head -n3 /etc/passwd 1> passwd.txt
echo
echo "Contents of passwd.txt"
cat passwd.txt

# Redirect STDERR to a file using FD2.
ERR_FILE="/tmp/data.err"
head -n3 /etc/passwd /fakefile 2> ${ERR_FILE}
echo "Contents of ${ERR_FILE}:"
cat ${ERR_FILE}

# Redirect STDOUT and STDERR to a file.
head -n3 /etc/passwd /fakefile > output.both 2<&1
echo "Contents of output.both:"
cat output.both

# Redirect STDOUT and STDERR through a pipe.
echo 'STDOUT and STDERR through a pipe'
head -n3 /etc/passwd /fakefile |& cat -n

# null device /dev/null
echo "send the standard output to null device"
echo 'Discarding STDOUT:'
head -n1 /etc/passwd /etc/hosts /fakefile > /dev/null

echo "send the standard error to null device"
echo 'Discarding STDERR:'
head -n1 /etc/passwd /etc/hosts /fakefile 2> /dev/null

echo "send the standard output and standard error to null device"
echo 'Discarding STDOUT and STDERR'
head -n1 /etc/passwd /etc/hosts /fakefile > /dev/null 2>&1
# or 
head -n1 /etc/passwd /etc/hosts /fakefile &> /dev/null

# Sometimes your script wants to send out the error information to STDERR.
# Test - run this script - ./local_user_9.sh 2> err
# cat err
echo 'Send output to STDERR' >&2

# Clean up
rm output.both /tmp/data.err head.both head.err passwd.txt head.out head1.both headAppend.both  uid  hello &> /dev/null
