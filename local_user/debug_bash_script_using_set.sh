#!/bin/bash

echo "This is line no.1"

echo 'Lets turn on the debugging using set command'

set -x

echo "Debugging turned on you will see + sign"

if [[ "${UID}" -eq 0 ]]
then
   echo "You are root"
else
   echo "You are non-root user"
fi

echo "Turning off the debug here using set +x"

set +x

if [[ "${#}" -gt 0 ]]
then
   echo "You have passed parameters: ${*}"
else
   echo "You have passed no parameters"
fi

echo "You can also debug the script manually using ./script_name -x"

exit 0


