#!/bin/bash


echo 'creating servers file having all server names'
echo 'server01' > servers
echo 'server02' >> servers

echo 'read servers'
cat servers

for SERVER in $(cat servers)
do
   ssh ${SERVER} hostname 
   ssh ${SERVER} uptime
done


echo 'here hostname runs on server01 but another hostname runs on the local host'
ssh server01 hostname; hostname

echo 'here hostname runs on server01 and another hostname runs again on server01'

ssh server01 'hostname ; hostname'

CMD1='hostname'
CMD2='uptime'

echo 'running as CMD1 and CMD2'
ssh server01 "${CMD1} ; ${CMD2}"

echo 'run listing all processes and display first 3 lines on server 1'
ssh server01 'ps -ef | head -3'

echo 'run listing all processes in server01 and first 3 lines i.e. head command locally'

ssh server01 ps -ef | head -3 

# man ssh 
# look for EXIT STATUS

echo 'ssh server03 which does not exists and then check the exit status'
echo 'You will see when ssh fails it returns the status 255.'
ssh server03 uptime
echo "${?}"

ssh server01 'set -o pipefail; false | true'

# help set | less

# pipefail - returns value of a pipeline. It is the status of the last command to exit with a non-zero status, or zero if no command exited with a non-zero status.






