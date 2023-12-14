#!/bin/bash

#finds top 5 processes and saves them to a variable
top_processes=$(ps aux --sort=-%cpu | head -6 | tail -5)

#shows the user the top 5 processes and asks to confirm before killing
echo "$top_processes"
echo "Would you like to kill these 5 processes? (y/n)"
read yesno

#will exit early if user does not enter y
if [ "$yesno" = 'y' ]
then
    num_killed=0
    while read -r line
    do
	#checks to make sure process wasnt started by root
        username=$(echo "$line" | awk '{print $1}')

        if [ "$username" != "root" ]
	then
	    #saves information for log file to variables (including the log file name)
	    current_date=$(date +"%Y-%m-%d")
	    log_file="$HOME/ProcessUsageReport-$current_date.log"
	    start_time=$(echo "$line" | awk '{print $9}')
   	    kill_time=$(date +"%Y-%m-%d %H:%M:%S")
      	    primary_group=$(id -gn "$username")

	    #kills process
	    pid=$(echo "$line" | awk '{print $2}')
	    kill -9 "$pid"

	    #saves information to the log file
            echo "Started by: $username" >> "$log_file"
   	    echo "Start time: $start_time" >> "$log_file"
   	    echo "Kill time: $kill_time" >> "$log_file"
   	    echo "Killed by: $primary_group" >> "$log_file"
   	    echo "" >> "$log_file"

	    #counts number of processes killed for logout message
	    ((num_killed++))
	fi
    done <<< "$top_processes"
    echo "$num_killed processes were killed."
else
    echo "Exited early. No processes were killed."
fi
