#! /bin/bash

# This explains cut and awk

# man cut 
# cut - remove sections from each line of files
# cut OPTION... [FILE]...

echo 'cut 1 character from /etc/passwd'
cut -c 1 /etc/passwd

echo 'cut 7th character from /etc/passwd'
cut -c 7 /etc/passwd

echo 'cut 4th to 7th character from /etc/passwd'
cut -c 4-7 /etc/passwd

echo 'cut 1st, 3rd and 5th character from /etc/passwd'
cut -c 1,3,5 /etc/passwd 

echo "cut doesn't follow sequence order"
echo "same as cut 5th, 3rd and 1st character from /etc/passwd"
cut -c 5,3,1 /etc/passwd 

echo "By default cut uses delimiter as tab"
echo "Specify some other delimiter in cut"
# use -d as delimiter
# use -f as the field to display.
echo 'one,two,three' | cut -d ',' -f 3

cut -d ':' -f 1,3 --output-delimiter=',' /etc/passwd 

echo 'Combine grep with cut'
# -v in the grep means invert the sense of matching.
grep -v '^shreyas' /etc/passwd | cut -d ':' -f 3 

echo 'You can also combine cut with grep'
cut -d ':' -f 1 /etc/passwd | grep -v '^shreyas'

# awk is important for shell scripting.
echo 'Using awk to print first and third field of /etc/passwd'
awk -F ':' '{print $1, $3}' /etc/passwd

echo 'Using awk to print third and first field of /etc/passwd'
awk -F ':' '{print $3, $1}' /etc/passwd

awk -F ':' '{print "UID:" $3 ", " "User Name:" $1}' /etc/passwd

echo 'Using awk to print the last character'
awk -F ':' '{print $NF}' /etc/passwd 

echo 'Using awk to print the second last character'
awk -F ':' '{print $(NF -1)}' /etc/passwd



