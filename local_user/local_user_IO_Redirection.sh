#!/bin/bash

# This script demonstrates I/O redirection.

# Standard Input, Standard Output, Standard Error.

# Redirects STDOUT to a file.

FILE="/tmp/data"

head -n1 /etc/passwd > ${FILE}

# id -un > id

# echo "${UID}" > uid
# cat uid

# Redirects STDIN to a program.
read LINE < ${FILE}
echo "LINE contains: ${LINE}"

# echo "secret" > password
# cat password 
# sudo passwd --stdin einstein < password

# Redirect STDOUT to a file, overwriting this file.
head -n3 /etc/passwd > ${FILE}
echo 
echo "Contents of a file: ${FILE}"
cat ${FILE}

# touch password
# cat password
# echo "another-line" >> password
# cat password
# date | sha256sum | head -c10 >> password
# cat password

# Redirect STDOUT to a file, appending to the file.
echo "${RANDOM} ${RANDOM}" >> ${FILE}
echo "${RANDOM} ${RANDOM}" >> ${FILE}
echo 
echo "Contents of ${FILE}:"
cat ${FILE}

