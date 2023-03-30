#!/usr/bin/env bash

# Set the path to the folder you want to fill with random strings
folder="/Users/user/folder"

# Set the maximum percentage of disk space to use
max_percent=95

# Generate a random string and write it to a file in the folder
random_string=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 10 | head -n 1)

# Loop until the folder size exceeds the maximum percentage of disk space
while true; do
    # Get the current disk usage percentage
    size=$(df / | tail -1 | tr -d '%' | awk '{print $5}')
    
    # If the disk usage percentage is greater than or equal to the maximum percentage, delete the folder and start over
    if [ $size -ge $max_percent ]; then
        rm -rf $folder
        mkdir $folder
    else
        # Write it to a file in the folder
        echo $random_string >> $folder/random
        # Update the folder size
        size=$(du -s $folder | awk '{print $1}')
    fi
done
