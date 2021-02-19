#!/bin/bash

for N in 1 2
do 
  ssh "server0${N}" hostname 
  ssh "server0${N}" cat /etc/hostname
done


