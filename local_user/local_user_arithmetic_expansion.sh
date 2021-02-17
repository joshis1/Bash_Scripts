#!/bin/bash

NUM=$(( 1 + 2 ))
echo "Sum of 1 + 2 is ${NUM}"

NUM=$(( 10 -1 ))
echo "Difference 10 - 1 is ${NUM}"

NUM=$(( 2 * 4 ))
echo "Multiply 2 * 4 = ${NUM}"

NUM=$((6/4))
echo "Divide 6 /4 = ${NUM}"

echo "Bash doesn't support floating point"

# if you want to use floating point then bc - external program called - basic calculator.

# type -a bc
# bc
# bc is /usr/bin/bc

echo "Dividing 6/5"
echo '6/5' | bc -l

echo "Play with basic calculator using bc"
# bc -l

echo "Playing with awk"
awk 'BEGIN {print 6/4}'

echo "Get the remainder 6/4"
NUM=$((6%4))
echo ${NUM}

##
DICEA='3'
DICEB='6'
TOTAL=$(( DICEA + DICEB ))
echo "Total of ${DICEA} + ${DICEB} = ${TOTAL}"

NUM='1'
(( NUM++ ))
echo "NUM ++"
echo ${NUM}

((NUM--))
echo "NUM --"
echo ${NUM}

((NUM+=5))
echo 'NUM +=5'
echo ${NUM}

# type -a expr
expr 1 + 1

NUM=$( expr 2 + 3)
echo ${NUM}


# type -a let
# let is a shell builtin

let NUM='2 + 3'
let NUM++
echo ${NUM}


