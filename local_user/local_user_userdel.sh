#!/bin/bash 

# type -a userdel
# which userdel

# it cannot find if it exists outside our path.

# locate userdel

# sudo updatedb --> this will update the db so that locate can find the file.

# ls -ld /*bin
# /bin
# /sbin

# ls -l /usr/bin/userdel
# ls -l /usr/sbin/userdel

# System administrator binaries are found in /usr/sbin.

# find /usr/sbin -iname userdel

# find / -iname userdel 2>/dev/null

# find ./ -iname "*sh" -exec grep -ir verbose {} \; -print

# type -a userdel
# userdel -f -> force

# id -u root
# 0

# id -u sshd 
# id -u sshd
# 105

# vi /etc/login.defs 

# id -u sshd
# 105

# sudo userdel -r neha
# delete home directory and all files within it. 

# archive
# tar - tape archives

# type -a tar 
# man tar 
# tar -c # create.
# tar -f # file. 
# tar -t - list the contents of an archive.
# xf # extract files from an archive.
# tar -xf archive.tar 
# tar -cf ../localuser.tar ../local_user/*
# tar -tf ../localuser.tar
# gzip ../localuser.tar
# localusr.tar.gz
# gunzip localuser.tar.gz -> localuser.tar
#

# tar -zcvf localuser.tar.gz ../local_user/
# tar -zxvf localuser.tar.gz
# tar -zxvf localuser.tar.gz  # extract the double compressed tar and gz.

# lock the account without disabling it.
# how to lock the account.
# man chage - change your password expiry information.
# -E - expiredate

# id samaya
# sudo passwd -l samaya  # locking the password.
# sudo passwd -u samaya  # unlocking the password.

# sudo usermod -s /sbin/nologin samaya

# This script deletes a user.

# Run as root.

if [[ "${UID}" -ne 0 ]]
then 
	echo 'Please run with sudo or as root.' >&2
	exit 1
fi 

# Assume the first argument is the user to delete.

USER="${1}"

# Delete the user.
userdel -r ${USER}

# Make sure the user got deleted.
if [[ "${?}" -ne 0 ]]
then
 	echo "The account ${USER} was not deleted" >&2
        exit 1
fi 

# Tell the user the account was deleted.
echo "The account ${USER} was deleted."

exit 0
