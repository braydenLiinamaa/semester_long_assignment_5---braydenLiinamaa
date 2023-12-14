#!/bin/bash

IFS=","

group_count="0"
user_count="0"

while read -r firstname lastname department
do
    # Creates proper user name based off the instructions
    username="${firstname::1}${lastname::7}"
    username=${username,,}

    # Clean up the department name
    department=$(echo "$department" | sed 's/[^a-zA-Z0-9]//g')

    # Check if the group exists
    if getent group "$department" >/dev/null 2>&1; then
        echo "ERROR: $department already exists"
    else
    # Adds new group it doesn't already exist
        sudo groupadd "$department"
	group_count=$((group_count + 1))
    fi

    # Check if the user exists
    if getent passwd "$username" >/dev/null 2>&1; then
        echo "ERROR: $username already exists"
    else
    # Adds new user if doesn't already exist and adds to group
        sudo useradd -G "$department" "$username"
	user_count=$((user_count + 1))
    fi

done < <(tail -n +2 EmployeeNames.csv)

echo "$user_count users have been added."
echo "$group_count groups have been added."
