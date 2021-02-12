#!/bin/bash

# This script demonstrates the if, elif, statement.

if [[ "${1}" = 'start' ]]
then
	echo 'Starting.'
elif [[ "${1}" = 'stop' ]]
then
	echo 'Stopping.'
elif [[ "${1}" = 'status' ]]
then
	echo 'Status.'
else
	echo 'Supply a valid option' >&2 
	exit 1
fi


