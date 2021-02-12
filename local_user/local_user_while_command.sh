#!/bin/bash

# This script is tested in Debian 9


# Demonstrate the use of shift and while loop.

# Display the first three parameters

echo "Parameter 1: ${1}"
echo "Parameter 2: ${2}"
echo "Parameter 3: ${3}"

# type -a while
# help while
# while: while COMMANDS; do COMMANDS; done
# Execute commands as long as a test succeeds.

X=1

while [[ "${X}" -eq 1 ]]
do 
	echo "This is the value of X: ${X}"
	X=7
done

# type -a true
# man true
# true - do nothing, successfully

# type -a sleep 
# sleep is /bin/sleep

# sleep 1s
# sleep .5s

#while [[ true ]]
#do 
#	echo "${RANDOM}"
#	sleep 1s
#done 

# type -a shift
# help shift
# It's actually a left shift.
# shift [n]

# Loop through all the positional parameters.
while [[ "${#}" -gt 0 ]]
do 
	echo "Number of parameters: ${#}"
	echo "Parameter 1: ${1}"
	echo "Parameter 2: ${2}"
	echo "Parameter 3: ${3}"
	echo
        shift 1 #shifts left side by 1.
done




