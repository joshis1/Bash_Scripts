# Using vagrant to run virtual machines.

- To bring up the 3 machines.

- vagrant init jasonc/centos7

- In my case, I already have vagrant file.

- vagrant up  - this will bring up all the 3 machines.

- vagrant status

- vagrant ssh admin01

- ping other ip addresses from admin01 

- ping -c 3 10.9.8.6

- ping -c 3 10.9.8.7

- echo '10.9.8.6 server01' | sudo tee -a /etc/hosts

- echo '10.9.8.7 server02' | sudo tee -a /etc/hosts

- sudo echo test >> /etc/hosts
-bash: /etc/hosts: Permission denied

- The problem is that we are running echo with sudo but >> is not running as sudo. That's why need tee command.


- ssh-keygen

- Copy your public key to server01.

- ssh-copy-id server01

- Copy your public key to server02.

-  ssh-copy-id server02

- execute command using ssh.

- executing command hostname for each server i.e. server01 and server02.

- for N in 1 2; do ssh "server0${N}" hostname; done








