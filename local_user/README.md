Use sudo with tee
$ sudo echo 1 > /proc/sys/net/ipv4/ip_forward
bash: /proc/sys/net/ipv4/ip_forward: Permission denied

The above sudo command resulted in permission denied because redirection is done by the shell which doesn't has write permission.

We can use sudo command with tee command to resolve this error:

$ echo 1 | sudo tee /proc/sys/net/ipv4/ip_forward


Use -e to pass echo as input to passwd

echo -e "linuxpassword\nlinuxpassword" | passwd linuxuser

Use --stdin to pass echo as input to passwd
# echo "linuxpassword" | passwd --stdin linuxuser

