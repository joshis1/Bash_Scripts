#!/bin/bash

# This script is tested in Debian 9

# This script creates an account on the local system.
# You will be prompted for the account name and password.

# Ask for the user name.
read -p 'Enter the username to create: ' USER_NAME

# Ask for the real name.
read -p 'Enter the name of the person who this account is for: ' COMMENT

# Ask for the password
read -p 'Enter the password to use for the account: ' PASSWORD

# Create the user 
#useradd -c "${COMMENT}" -m ${USER_NAME}
adduser ${USER_NAME} 

# Set the password for the user.
# echo ${PASSWORD} | passwd --stdin ${USER_NAME}

echo "${USER_NAME}:${PASSWORD}" | chpasswd

# Force password change on first login.
passwd -e ${USER_NAME}

# type -a read
# help read | less

# man useradd 
# man passwd
# user login generally is 8 characters long, check ps -ef to see how it truncates.
# -m uses skel directory 
# /etc/login.defs -- configuration
# su - <login id>



