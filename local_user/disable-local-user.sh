#!/bin/bash



# Enforce the script is executed with superuser privilege.

if [[ "${UID}" -ne 0 ]]
then
  echo "Usage: Please run this script as super user" >&2
  exit 1
fi


usage()
{
  echo 'Usage: sudo ./disable-local-user.sh USER_ACCOUNT' >&2
  exit 1 
}

# Check that the user account is provided.

if [[ "${#}" -lt 1 ]]
 then 
   usage
fi

unset account
# help test
# -z STRING      True if string is empty.
if [[ -z "${account}" ]]
then
	echo "Unset account -z worked - empty string"
fi

while getopts a:r:d: OPTION
do 
  case ${OPTION} in
 a)
   ACCOUNT=${OPTARG}
   echo "creates an archive of the account: ${ACCOUNT}"
   ARCHIVE='true'
   ;;
 d)
    ACCOUNT=${OPTARG}
    echo "Deletes account instead of disabling them: ${ACCOUNT}"
    DELETE='true'
    ;;
 r)
    ACCOUNT=${OPTARG}
    REMOVE_DIR='true'
    echo "Removes the home directory associated with the account: ${ACCOUNT}"
    ;;
 ?)
    usage
    exit 1
    ;;
  esac
done

shift "$(( ${OPTIND} - 1 ))"

echo "Number of arguments"
echo "${#}"
echo "${1}"

if [[ "${#}" -eq 1 ]]
 then
   ACCOUNT="${1}"
   if [[ $(id -u ${ACCOUNT}) -lt 1000 ]]
   then
	 echo "Refusing to remove the ${ACCOUNT} account with UID $(id -u ${ACCOUNT})"
   else
   passwd -l "${ACCOUNT}"
   exit 1
   fi
fi

case ${ACCOUNT} in 
a) usage;;
d) usage;;
r) usage;;
esac



USR_ID=$(id -u ${ACCOUNT})

if [[ ${USR_ID} -lt 1000 ]]
then
  echo ${USR_ID}	
  echo 'Only system accounts should be modified by system administrator'
  exit 1
fi

if [[ "${ARCHIVE}" = true ]]
 then
   tar -zcvf /home/${ACCOUNT}.tar.gz /home/${ACCOUNT}
elif [[ "${REMOVE_DIR}" = true ]]
 then
    userdel -r ${ACCOUNT}
else
    userdel ${ACCOUNT}
fi

if [[ "${?}" -ne 0 ]]
 then
 	echo "Failed to delete the account ${ACCOUNT}" >&2
fi

echo "Deleted the account: ${ACCOUNT}"

exit 0













