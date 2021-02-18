#!/bin/bash

LOG_FILE="${1}"

if [[ ! -e "${LOG_FILE}" ]]
then
    echo "Cannot open log file: ${LOG_FILE}" >&2
    exit 1
fi

# Count the number of failed login by IP address.

# If there any IPs with over LIMIT failure then display the count, IP and location.

LIMIT='10'


# Display the csv header.

echo 'Count,IP,Location'
# loop through the list of failed attempts.
grep Failed syslog-sample | awk -F 'from' '{print $2}'|  awk '{print $1}' | sort | uniq -c | sort -rn | while read COUNT IP
do
if [[ "${COUNT}" -gt "${LIMIT}" ]]
then
	# geoiplookup ${IP}
	LOCATION=$(geoiplookup ${IP} | head -1 | awk '{print $5}')
        echo "$COUNT,${IP},${LOCATION}"
fi
done

exit 0
