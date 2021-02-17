#!/bin/bash

# This script demonstrates getopts

# This script generates a random password.

# This script can set the password length with -l and add a special character with -s.

# Verbose mode can be enabled with -v.

# Set a default password length.

# Usage example -
# ./local_user_getopts.sh -vsl 4


LENGTH=48

usage()
{
  echo "Usage: ${0} [-vs] [-l LENGTH]" >&2
  echo 'Generating a random password.'
  echo '-l Length specify the password length.'
  echo '-s Append a special character to the password.'
  echo '-v Increase verbosity.'
  return 1
}

log()
{
  local MESSAGE="${@}"
  if [[ "${VERBOSE}" = 'true' ]]
   then 
	# echo 'Generating a password'
	echo "${MESSAGE}"
  fi
}

# length should have an argument.
while getopts vl:s OPTION
do
   case ${OPTION} in 
   v)
     VERBOSE='true'
     echo 'Verbose is set'
     ;;
   l) 
     LENGTH="${OPTARG}"
     echo "Length is set to ${LENGTH}"
     ;;
   s)
      USE_SPECIAL_CHARACTER='true'
      echo 'Special character is set'
      ;;
   ?)
      #echo 'Invalid Option'
      usage 'Invalid option'
      exit 1
      ;;
   esac
done

# getopts doesn't change the positional parameters.
echo "Number of Arguments: ${#}"
echo "All args: ${@}"
echo "First arg: ${1}"
echo "Second arg: ${2}"
echo "Third arg: ${3}"

#Inspect OPTIND

# Remove the options while leaving the remaining arguments.
shift $(( ${OPTIND} - 1 ))
echo "After the shift:"
echo "Number of Arguments: ${#}"
echo "All args: ${@}"
echo "First arg: ${1}"
echo "Second arg: ${2}"
echo "Third arg: ${3}"

if [[ "${#}" -gt 0 ]]
then
   usage 'Invalid Option'
   exit 1
fi


log 'Generating a password'
PASSWORD=$(date +%s${RANDOM}${RANDOM} | sha256sum | head -c ${LENGTH})

# Append a special character if requested to do.

if [[ "${USE_SPECIAL_CHARACTER}" = 'true' ]]
then
  log 'Selecting a random special character'
  SPECIAL_CHARACTER=$(echo '!@#$%^&*()_=-+' | fold -w1 | head -c1)
  log ${SPECIAL_CHARACTER}
  PASSWORD=${PASSWORD}${SPECIAL_CHARACTER}
fi
log 'Done.'
log 'Here is the password'
# Display the password.
echo ${PASSWORD}

exit 0


# In case you provide illegal option then you will hit ?)
# ./local_user_getopts.sh -j
# ./local_user_getopts.sh: illegal option -- j
# Usage: ./local_user_getopts.sh [-vs] [-l LENGTH]
# Generating a random password.
# -l Length specify the password length.
# -s Append a special character to the password.
# -v Increase verbosity.

# Enabling all the options - s -special, v -verbose and l length followed by the value i.e. 8 in my example.
# ./local_user_getopts.sh -svl 8
