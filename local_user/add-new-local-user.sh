#!/bin/bash

# This script tested in Centos7.

# This script creates a new user on the local system.
# You must supply a username as an argument to the script.
# Optionally, you can also provide a comment for the account as an argument.
# A password will be automatically generated for the account.
# The username, password, and host for the account will be displayed.

# Make sure the script is being executed with superuser privileges.
if [[ "${UID}" -ne 0 ]]
then
	echo 'Please run with sudo or as root.'
	exit 1
fi


# If the user doesn't supply at least one argument, then give them help.

if [[ "${#}" -lt 1 ]]
then 
	echo 'Usage: ./add-new-local-user.sh USER_NAME [COMMENT]...'
    echo 'Create an account on the local system with the name of USER_NAME and a'
    echo 'comments field of COMMENT.'
	exit 1
fi


# The first parameter is the user name.
USER_NAME="${1}"
echo "USER_NAME: ${USER_NAME}"

# The rest of the parameters are for the account comments.
shift 1
COMMENT="${*}"
echo "COMMENT:  ${COMMENT}"

# Generate a password.
SPECIAL_CHARACTER=$(echo '!@#$%^&*()_+-=' | fold -w2 | shuf | head -c2)
echo "SPECIAL_CHARACTER: ${SPECIAL_CHARACTER}"
PASSWORD=$(date +%s%N${RANDOM} | sha256sum |  shuf | head -c4)${SPECIAL_CHARACTER}
echo "PASSWORD: ${PASSWORD}"


# Create the user with the password.
useradd -m ${USER_NAME} -c "${COMMENT}"

# Check to see if the useradd command succeeded.
if [[ "${?}" -ne 0 ]]
then 
	echo "Failed to create account for username: ${USER_NAME}"
	exit 1
fi 

# Set the password.
echo ${PASSWORD} | passwd --stdin ${USER_NAME}


# Check to see if the passwd command succeeded.
if [[ "${?}" -ne 0 ]]
then 
	echo "Failed to set password for username: ${USER_NAME}"
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