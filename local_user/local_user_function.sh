#!/bin/bash

# This script demonstrates function.

log() {
echo 'You called the log function!'
}

log

log1()
{
 local MESSAGE="${@}"
 logger -t local_user_function.sh "${MESSAGE}"
 if [[ "${VERBOSE}" = 'true' ]]
 then
	 echo "${MESSAGE}"
 fi
}


log1 'Hello!'
VERBOSE='true'
log1 'This is fun!'

log2()
{
	local VERBOSE="${1}"
	echo "Check verbose"
	echo ${VERBOSE}
	shift
	local MESSAGE="${@}"
	if [[ ${VERBOSE} = 'true' ]]
	then
		echo "${MESSAGE}"
	fi
}

log2 'true' 'Shreyas Joshi'
log2 'false' 'Neha'
readonly VERBOSITY='true'
log2 "${VERBOSITY}" 'Hello Verbosity working'

# type -a logger
# logger is /usr/bin/logger
# logger - enter messages into the system log
# logger [options] [message]

logger 'Hello from the command line!'
logger -t my-script 'Tagging on'

# Don't call a function without defining it.

backup_file()
{
	local FILE="${1}"
  # Make sure the file exists
  if [[ -f "${FILE}" ]]
  then
	# -F Full date
  	local BACKUP_FILE="/var/tmp/$(basename ${FILE}).$(date +%F-%N)"
	log "backing up ${FILE} to ${BACKUP_FILE}"
  # The exit status of the function will be the exit status of the cp command.
  # -p preserve - timestamps, ownership.
  cp -p ${FILE} ${BACKUP_FILE}
else
	# The file does not exists, so return a non-zero exit status.
	return 1
  fi
}

backup_file '/etc/passwd'

if [[ "${?}" -eq '0' ]]
 then 
	log1 'File backup succeded'
 else
        log1 'File backup failed!'
	exit 1
fi


