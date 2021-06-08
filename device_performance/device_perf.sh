#!/bin/bash

# This script will get instrumented data for performance measurement.

test_file_disk_dump() {
   echo  'file disk dump test starting'
   results=$(dd if=/dev/zero of=/dev/null bs=1024 count=10 2>&1)
   time=$(echo -n $results | cut -d ',' -f 2)
   echo 'Total time in seconds to file disk dump in secs = '$time
   echo $'file disk dump test stopped \n'
}


test_find_time() {
	echo 'find test starting'
	TIMEFORMAT='%3lR'
        exec 3>&1 4>&2
        var=$( { time find / -type f > /dev/null  2>&1;  1>&3- 2>&4-; } 2>&1 )  # Captures time only.
        echo $var
        min=$(echo $var | awk -F 'm|s' '{print $1}')
        secs=$(echo $var | awk -F 'm|s' '{print $2}')
        echo $min
        echo $secs
        $(( mins = min * 60))
       echo "print minutes"
        echo $mins
        $(( total_time = mins + secs ))
        echo $total_time
        total_files=$(find / -type f | wc -l)
        echo 'Total files = '$total_files
        echo 'Total time in secs = '$total_time 
        ((time = total_time/total_files))
        echo $'Time to access each file average in seconds = time'
	echo 'find test stopped'
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
        *)
                echo "Usage: $0 {dd|find}"
                echo ""
                echo $"Let's run all the tests" $'\n'
                test_file_disk_dump   
                test_find_time                
		;;
esac


