#!/bin/bash 

# This script is tested in Debian 9

# The above line is Shebang telling the interpreter which is used here i.e. bash.

# We can have Shebang as /bin/python for interpreting python programs or /bin/ruby for interpreting ruby programs

# This script displays various information to the screen.

# Display 'Hello'

echo 'Hello'

# Execute bit in the file 

# rw- u
# r-- g
# r-- o

# chmod 755 local_user_1.sh

# touch blah.sh , creates empty file if it doesn't exist or update the last access time.

# type -a echo
# echo is a shell builtin
# echo is /bin/echo

# For shell built-in utility.
# help echo | less

# For external utility, use man i.e. manual pages.
# type -a uptime
# uptime is /usr/bin/uptime
# man uptime | less 
# type q to exit from pagination system 

# Assign a value to a variable
# Convention is to give upper case for the variable name.
# no space between assignment operator
# valid variable names - WORD, _WORD
# Invalid variable names - 3WORD, A-WORD, E@MAIL

WORD='script'

# Display the variable value
echo "$WORD"

# " " - double quote expands
# '' - single quote doesn't expand.

# Demonstrate that single quotes causes variables not to get expanded
echo '$WORD'

# Combine the variable with hard coded text
echo "This is a shell $WORD"

# Display the contents of the variable using an alternative syntax
echo "This is a shell ${WORD}"

# Append text to the variable
echo "${WORD}ing is fun!"

# Show how not to append text to a variable, this doesn't work
echo "$WORDing is fun!"

# Create a new variable
ENDING='ed'
# Combine the two variables
echo "This is ${WORD}${ENDING}."

# Change the value stored in the ENDING variable - reassignment
ENDING='ing'
echo "${WORD}${ENDING} is fun"

# Reassign value to ENDING
ENDING='s'
echo "You are going to write many ${WORD}${ENDING} in the class!"

# Remember - double quote is expanded, use embracing style ${} 


