#!/bin/bash

# This script is tested in Debian 9

# Display the UID and username of the user executing the script.
# Display if the user is the root user or not.

# Display the UID

echo "Your UID is ${UID}"

# man bash
# /UID -- search for UID
# /n  for next search
# UID Expands to the user ID of the current user, initialized at shell startup.
# UID - read only
# EUID - effective user id of the current user, readonly.
# when we do setuid, EUID will become 0. setuid isn't allowed in modern system.
# ?Shell - ? is for reverse search
# q to quit the man page.


#  UID="1001"
# -bash: UID: readonly variable

# type -a id
# id is /usr/bin/id

# man id 
# SYNOPSIS  id [OPTION]... [USER]
# ... means ellipsis - meaning multiple of options.
# [ ] - square bracket means optional.
# [USER] - only one option.
# [OPTION]... -- means multiple options can be combined.
# -n - prints a name instead of a number.
# -u - prints only the effective user id.
# id -un
# whoami

# Display the username

echo "Newer style - Your username is $(id -un)"

echo "Using old Style - backticks - Your username is `id -un`"

echo "Using whoami command - Your username is $(whoami)"

# type -a whoami
# whoami is /usr/bin/whoami
# man whoami

USER_NAME=$(id -un)
echo "Your userName is ${USER_NAME}"

# Display if the user is the root user or not

if [[ "${UID}" -eq 0 ]]
then
     echo 'You are root'
else 
     echo 'You are not root'
fi

# type -a if
# if is a shell keyword

# help if
#if: if COMMANDS; then COMMANDS; [ elif COMMANDS; then COMMANDS; ]... [ else COMMANDS; ] fi    Execute commands based on conditional.

# ; is a command seperatoror or you can use new line.

# type -a [[ 
# [[ is a shell keyword
# help [[
# [[ ... ]]: [[ expression ]]
#    Execute conditional command.

# $ type -a test
# test is a shell builtin
# help test
# test: test [expr]
#    Evaluate conditional expression.

# root always has a UID of 0.
# sudo - super user do.

# [[ is the new way to do, but you can use [ - single bracket also.
# [ is a command in the linux 


