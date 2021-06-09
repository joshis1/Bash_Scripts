#!/bin/bash

# This script will get instrumented data for performance measurement.


# Check if the script is running as root or not.
# We need this because we need to run find on the root file system.

if [[ "${UID}" -ne 0 ]]
then
		echo 'Please run with sudo or as root.'
      exit 1
fi

# We need to do floating point maths, unfortunately bash doesn't have built-in floating point support
# We are using awk for floating point operations like seconds in 0.068 addition
# We need to set Locale to C type so that awk can do floating point operations.

LC_NUMERIC="C"

file_exists=0

## This is to prepare the test file more than 10MB then run cat on it 
## Next this data can be used to concat and various things.
## Perhaps, we can do performance measurement while preparing data??
## Keeping it simple and just preparing the test data here.

## If the test data exists then no need to run this everytime.

if [ -f test1 ]; then
   file_exists=1
   #echo "test file exists."
   test_size=$(du test1)
   echo $test_size
   test_file_size=$(echo $test_size | head -n1 | cut -d " " -f1)
   echo $test_file_size
   if [ $test_file_size -le 300 ]; then
	    file_exists=0
   fi
fi

if [ $file_exists -eq 0 ]; then
    echo "Creating test file"
    cat /etc/host.conf > test1
    cat /etc/host.conf > test
    size=0
    while [ $size -le  300 ]
    do
      size_total=$(du test1)
      size_val=$(echo $size_total | head -n1 | cut -d " " -f1)
      #echo $y
      size=$size_val   
      cat test /etc/host.conf >> test1
      file_exists=1
      #b=$(( $b + 1 ))
    done 
fi

### Test data preparation done 

#### Test starting here ############


########################################


### dd test -- check disk dump copy from RAM to RAM 

#####################################################
test_file_disk_dump() {
   echo  'file disk dump test starting'
   results=$(dd if=/dev/zero of=/dev/null bs=1024 count=10 2>&1)
   time=$(echo -n $results | cut -d ',' -f 2)
   echo $'Total time in seconds to file disk dump in secs = ' $time
   echo $'file disk dump test stopped \n'
}


### find test -- check access time for each file 

#####################################################
test_find_time() {
	echo 'find test starting'
	TIMEFORMAT='%3lR'
    exec 3>&1 4>&2
    var=$( { time find / -type f > /dev/null  2>&1;  1>&3- 2>&4-; } 2>&1 )  # Captures time only.
    #echo $var
    min=$(echo $var | awk -F 'm|s' '{print $1}')
    secs=$(echo $var | awk -F 'm|s' '{print $2}')
    #echo $min
    #echo $secs
    mins=$(( min * 60 ))
    #echo "print minutes"
    #echo $mins
    #echo 'print seconds'
    #echo $secs
    total_time=$( awk "BEGIN {print ($mins + $secs)}" )
    #echo 'total time is '
    #echo $total_time
    total_files=$(find / -type f | wc -l)
    #echo 'Total files = '$total_files
    #echo 'Total time in secs = '$total_time 
    time=$( awk "BEGIN {print ($total_time/$total_files)}")
    echo $'Time to access each file average in seconds = ' $time
	echo 'find test stopped'
}


### tftp test -- check how long it takes to download a file from tftp server
### Assuming tftp server IP address as 11.11.11.1 
### Instead of hardcode of 11.11.11.1 to do change it ??

#####################################################
test_tftp_time() {
	echo 'tftp test starting'
	TIMEFORMAT='%3lR'
    exec 3>&1 4>&2
    var=$( { time  tftp -g -r ubi.img  11.11.11.1 > /dev/null  2>&1;  1>&3- 2>&4-; } 2>&1 )  # Captures time only.
    echo 'var'
    echo $var
    echo "Var is done"
    min=$(echo $var | awk -F 'm|s' '{print $1}')
    secs=$(echo $var | awk -F 'm|s' '{print $2}')
    echo 'min'
    echo $min
    echo 'secs'
    echo $secs
	mins=$( awk "BEGIN {print ($min * 60)}" )
    #mins=$(( min * 60 ))
    #echo "print minutes"
    #echo $mins
    #echo 'print seconds'
    #echo $secs
    total_time=$( awk "BEGIN {print ($mins + $secs)}" )
	ubi_img_size=$(du -h ubi.img)
    ubi_img_size_only=$(echo $ubi_img_size | head -n1 | cut -d " " -f1)
    echo $'ubi img size downloaded = ' $ubi_img_size_only
    echo $'Total time to download ubi.img from TFTP Server = ' $total_time
	echo 'tftp test stopped'
}

##################################
# Main script logic starts here #

###################################
case "$1" in
        dd)
                test_file_disk_dump   
                ;;
	    find)
                test_find_time                
                ;;
		tftp)
                test_tftp_time                
                ;;
        *)
                echo "Usage: $0 {dd|find|tftp}"
                echo ""
                echo $"Let's run all the tests" $'\n'
                test_file_disk_dump   
                test_find_time
                test_tftp_time				
		;;
esac


