#!/bin/bash
#

# This script tested in Centos7.

# This script creates a new user on the local system.
# You will be prompted to enter the username (login), the personal name, and a password.
# The username, password, and host for the account will be displayed.

# Make sure the script is being executed with superuser privileges.

if [[ "${UID}" -ne 0 ]]
then 
	echo 'Please run with sudo or as root.'
	exit 1
fi

# Get the username (login).
read -p 'Enter the username to create: ' USER_NAME


# Get the real name (contents for the description field).
read -p 'Enter the name of the person or application that will be using this
account: ' COMMENT 

# Get the password.
read -p 'Enter the password to use for the account: ' PASSWORD

# Create the user with the password.
useradd -m ${USER_NAME} -c "${COMMENT}"

# Check to see if the useradd command succeeded.
if [[ "${?}" -ne 0 ]]
then 
 echo 'failed to create the account'
 exit 1
fi 

# Set the password.
echo "${PASSWORD}" | passwd --stdin ${USER_NAME}


# Check to see if the passwd command succeeded.
if [[ "${?}" -ne 0 ]]
then 
 echo 'failed to create the account'
 exit 1
fi 

# Force password change on first login.
passwd -e ${USER_NAME}

# Display the username, password, and the host where the user was created.
echo 'username :'
echo ${USER_NAME}

echo 'password:'
echo ${PASSWORD}

echo 'host:'
# By convention we know that anything in uppercase is a variable
echo ${HOSTNAME}

exit 0

# testing su - <newuser>
# tested with centos7.