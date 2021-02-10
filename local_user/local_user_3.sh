#!/bin/bash

# This script is tested in Debian 9


# Display the UID and username of the user executing this script.
# Display if the user is the vagrant user or not.

# Display the UID
echo "Your UID is ${UID}"


# Display only if the UID does not match 1000
UID_TO_TEST_FOR='1000'
# DRY - Don't repeat yourself

# man useradd 
# EXIT VALUES
# The useradd command exits with the following values:
# 0 success

if [[ "${UID}" -ne "${UID_TO_TEST_FOR}" ]]
then
   echo "Your UID does not match ${UID_TO_TEST_FOR}"
   exit 1
fi

# type -a exit
# exit is a shell builtin

# help test

# Display the username

USER_NAME=$(id -un)

# Test if the command succedded 
if [[ "${?}" -ne 0 ]]
then 
echo 'The id command did not execute successfully'
exit 1
fi

echo "Your username is ${USER_NAME}"

# ${?} - exit status of the recently run command 
# id -un 
# echo "${?}" -- 0
# id -invalid
# echo "${?}" -- 1  -- exit return with error.


# You can use a string test conditional
USER_NAME_TO_TEST_FOR='shreyas'

if [[ "${USER_NAME}" = "${USER_NAME_TO_TEST_FOR}" ]]
then 
echo "Your username matches ${USER_NAME}"
fi 

# = inside the test operator is not assignment operator but a comparator operator - matches exactly
# == inside the test operator is a pattern matching operator.

# Test for != (not equal) for the string

if [[ "${USER_NAME}" != "${USER_NAME_TO_TEST_FOR}" ]]
then 
echo "Your username does not match ${USER_NAME_TO_TEST_FOR}."
exit 1
fi 

exit 0

# exit - by default exit returns the exit status of previously executed command

