#!/bin/bash

# This script is tested in Debian 9


# This script generates a random password for each user specified on the command line.

# Display what the user typed on the command line.
echo "You executed this command: ${0}"

# {0} is the script name, the command.

# man bash look for PATH using /PATH

echo ${PATH}

# hash -r # to forget all remembered locations.

# which head
# /usr/bin/head

# man basename
# basename - strip directory and suffix from filenames

#  basename ./Documents/viewAttachment.pdf
#  viewAttachment.pdf

# man dirname
# dirname - strip last component from file name
# dirname ./Documents/viewAttachment.pdf
# ./Documents

# Display the path and filename of the script.
echo "You used $(dirname ${0}) as path to the $(basename ${0}) script"

# man bash /Special Parameters

# Tell them how many arguments they passed in.
NUMBER_OF_PARAMETERS="${#}"
echo "You supplied ${NUMBER_OF_PARAMETERS} argument(s) on the command line."

# Make sure they supply at least one argument.

if [[ "${#}" -lt 1 ]]
then
	echo "Usage: ${0} USER_NAME [USER_NAME]..."
	exit 1
fi

# help test to check lt, which stands for less than

# type -a for
# for is a shell keyword

# for: for NAME [in WORDS ... ] ; do COMMANDS; done
#    Execute commands for each member in a list.

# for x in Shreyas Samaya Neha
# do 
#	echo "Hi ${x}"
# done

for USER_NAME in "${@}"
do 
	PASSWORD=$(date +%s%N | sha256sum | head -c48)
        echo "${USER_NAME} : ${PASSWORD}"
done

# $* will treat all arguments as 1 argument





