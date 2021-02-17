#!/bin/bash

# /bin/bash -xev  for debugging.

# This script disables, deletes, and/or archives users on the local system.

readonly ARCHIVE_DIR='/archive'

test_run()
{
   if [[ "${?}" -ne 0 ]]
   then
	echo "${*}" >&2
	exit 1
   fi
}

date 

test_run "Failed to run date"

usage()
{
# Display the usage and exit.
echo "Usage: ${0} [-dra] USER [USERN]..." >&2
echo 'Disable a local linux account.' >&2
echo '-d Deletes acccounts instead of disabling them.' >&2
echo '-r Removes the home directory associated with the account(s).' >&2
echo '-a Creates an archive of the home directory associated with the account(s).' >&2
exit 1
}

# Make sure the script is being executed with superuser privileges.

if [[ "${UID}" -ne 0 ]]
then
  echo 'Please run with sudo or as root.' >&2
  exit 1
fi

# Parse the options.

while getopts dra OPTION
do 
  case ${OPTION} in 
  d) DELETE_USER='true' ;;
  r) REMOVE_OPTION='-r' ;;
  a) ARCHIVE='true' ;;
esac
done

# Remove the options while leaving the remaining arguments.
shift "$(( ${OPTIND} - 1 ))"

# If the user doesn't supply at least one argument, give them help.

if [[ "${#}" -lt 1 ]]
then 
    usage
fi 

# Loop through all the usernames supplied as arguments.
for USERNAME in "${@}"
do 
echo "Processing user: ${USERNAME}"

# Make sure the UID of the account is at least 1000.
USERID=$(id -u ${USERNAME})

if [[ "${USERID}" -lt 1000 ]]
then 
  echo "Refusing to remove the ${USERNAME} account with UID ${USERID}" >&2
  exit 1
fi 

# Create an archive if requested to do so.
if [[ "${ARCHIVE}" = 'true' ]]
then
# Make sure the ARCHIVE DIR directory exists.
if [[ ! -d "${ARCHIVE_DIR}" ]] 
then 
     echo "Creating ${ARCHIVE_DIR} directory"
     mkdir -p ${ARCHIVE_DIR}
     test_run "The archive directory ${ARCHIVE_DIR}  could not be created"
fi

# Archive the user's home directory and move it into the ARCHIVE_DIR

HOME_DIR="/home/${USERNAME}"
ARCHIVE_FILE="${ARCHIVE_DIR}/${USERNAME}.tgz"

if [[ -d "${HOME_DIR}" ]]
then 
 echo "Archiving ${HOME_DIR} to ${ARCHIVE_FILE}"
 tar -zcf ${ARCHIVE_FILE} ${HOME_DIR} &> /dev/null
 test_run "Could not create ${ARCHIVE_FILE}"
else
   echo "${HOME_DIR} does not exists or is not a directory" >&2
   exit 1
fi
fi

if [[ "${DELETE_USER}" = 'true' ]]
then
# Delete the user.
userdel ${REMOVE_OPTION} ${USERNAME}
test_run "The account ${USERNAME} was not deleted."
echo "The account ${USERNAME} was deleted."
else
 chage -E 0 ${USERNAME}
 test_run "The account ${USERNAME} was not disabled."
 echo "The account ${USERNAME} was disabled."
fi
done

exit 0









