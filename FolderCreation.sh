#!/bin/bash

count=0

# creates EmployeeData folder if it doesn't exist
if [ ! -d /EmployeeData ]; then
    mkdir /EmployeeData
    ((count++))
fi

# creates subfolders for each group
if [ ! -d /EmployeeData/HR ]; then
    mkdir /EmployeeData/HR
    ((count++))
fi

if [ ! -d /EmployeeData/IT ]; then
    mkdir /EmployeeData/IT
    ((count++))
fi

if [ ! -d /EmployeeData/Finance ]; then
    mkdir /EmployeeData/Finance
    ((count++))
fi

if [ ! -d /EmployeeData/Executive ]; then
    mkdir /EmployeeData/Executive
    ((count++))
fi

if [ ! -d /EmployeeData/Administrative ]; then
    mkdir /EmployeeData/Administrative
    ((count++))
fi

if [ ! -d /EmployeeData/CallCenter ]; then
    mkdir /EmployeeData/CallCenter
    ((count++))
fi

# modifies permissions for all folders except Executive and HR
chmod -R 764 /EmployeeData
chmod -R 764 /EmployeeData/IT
chmod -R 764 /EmployeeData/Finance
chmod -R 764 /EmployeeData/Administrative
chmod -R 764 /EmployeeData/CallCenter

# modifies permissions for HR and Executive
chmod -R 760 /EmployeeData/HR
chmod -R 760 /EmployeeData/Executive

# changes the owner of each folder to the respective group
chgrp root /EmployeeData
chgrp HR /EmployeeData/HR
chgrp IT /EmployeeData/IT
chgrp Finance /EmployeeData/Finance
chgrp Executive /EmployeeData/Executive
chgrp Administrative /EmployeeData/Administrative
chgrp CallCenter /EmployeeData/CallCenter

echo "$count folders were created."
