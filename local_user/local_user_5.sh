#!/bin/bash

# This script is tested in Debian 9


# This script generates a list of random password.

# A random number as password

# !v --> previously executed command with vim 

# man bash - search for RANDOM

PASSWORD="${RANDOM}"

echo "${PASSWORD}"

# Three random numbers together

PASSWORD="${RANDOM}${RANDOM}${RANDOM}"

echo "Three random together is : ${PASSWORD}"

# Use the current date/time as the basis for the password.
PASSWORD=$(date +%s%N)
echo "Date based password in seconds and nanoseconds ${PASSWORD}"

# checksum, cryptographic functions.

PASSWORD=$(date +%s%N | sha256sum)

echo "Cryptographic sha256sum based password ${PASSWORD}"

# man sha256sum

# sha256sum [OPTION]... [FILE]... 

# in the man page, when you see [FILE] option that means you can use pipe command for input.

# head command.

# type -a head 
# head is /usr/bin/head
# man head 

# Output the first part of the files.
# $ head -n1 /etc/passwd
# top or beginning lines.
# root:x:0:0:root:/root:/bin/bash

echo "testing" | head -c4

echo

# A better password
PASSWORD=$(date +%s%N | sha256sum | head -c32)

echo "32 characters long password: ${PASSWORD}"

# Password with 32 characters long with RANDOM number.

PASSWORD=$(date +%s%N${RANDOM}${RANDOM}${RANDOM}| sha256sum | head -c32)

echo "32 characters long password with RANDOM: ${PASSWORD}"

# man shuf

# shuf - generate random permutations

# shuf /etc/passwd

# man fold 
# fold - wrap each input line to fit in specified width
# fold - single to multiple lines using w option.
# fold /etc/passwd -w1 | more

# Append a special character to the password.
SPECIAL_CHARACTER=$(echo '!@#$%^&*()_-+=' | fold -w1 | shuf | head -c1)
echo "Got random special character: ${SPECIAL_CHARACTER}"

echo "Combining special character with password: ${PASSWORD}${SPECIAL_CHARACTER}"


