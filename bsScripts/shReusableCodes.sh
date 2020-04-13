#!/bin/bash

## Author: Neeraj Singh Junior;
## Created Date: 2020 April, 12;
## Upated Date: 2020 April, 12;
## Objective: Reusable lines of code which is going to be repeated in future
## scripts of mine, that's why saving them

# Display Menu Of The Script
function makeMenu() {    
    echo -e "\n"
    echo "|>>|_Hello & Welcome, `whoami` ...";
    echo " ____________________________________________";
    echo "|__|_Account Types availables ________________|";
    echo "|1.|_Rename Files Of Current Directory. ______|";
    echo "|2.|_Rename Files Of Other Directory. ________|";
    echo "|3.|_Move All Files Of This Directory. _______|";
    echo "|4.|_Delete All Files and Folder In Directory.|";
    echo "|5.|_List all this Folder. ___________________|";
    echo "|6.|_Search for a Files In Current Directory. |";
    echo "|7.|_Exit. ___________________________________|";
    echo "|__|__________________________________________| "
    echo -e "\n"
    read -p "|>>|_Your Choice: " choice;
    if [ ${?} -ne 0 ]; then 
        echo "Exception interruption at menu input ...";
        exit 1
    fi
    return 0;
}

# Capturing Error Log;
function errorLog() {
     if [ $? -ne 0 ]; then   
        echo "Error occured while creating U/A backup";
        error=`/sbin/modprobe -n -v hfsplus 2>&1`;
        echo "Error: ${error}";
        echo "Script Terminate: ${?}";
        exit 1;
    fi
    return 0;
}

# Generate Random Number;
function randomize() {
    local password="${1}@${RANDOM}";
    if [ ${?} -ne 0 ]; then 
        echo "Password generation exited with status 1";
        exit 1;
    fi
    echo "$password";
    return 0;
}

# Creating backup in text files;
function backupUserAccount() {
    location='your_location';
    # Backup file dump at location;
    if [ -d $location ]; then
        echo "|`date` | $1 | $2 | $3 |" >> ${location}/"your_file_name.txt";
    else
        mkdir $location;
        echo "|`date` | $1 | $2 | $3 |" >> ${location}/"your_file_name.txt";
    fi
    # Checking, if Status is 0;
    if [ $? -ne 0 ]; then   
        echo "Error occured while creating U/A backup";
        error=`/sbin/modprobe -n -v hfsplus 2>&1`;
        echo "Error: ${error}";
        echo "Script Terminate: ${?}";
        exit 1;
    fi
    return 0
}

# Main Conditional Program Execution Calls;
if [ $choice == 1 -o $choice == 2 ]; then 
        clear    # Clear Screen;
        echo "Starting Process Of Creating Account ...";
        createUserAccount;

elif [ $choice == 3 -o $choice == 4 ]; then
        clear    # Clear Screen;
        echo "Starting Process Of Deleting Account ...";
        deleteUserAccount 

elif [ $choice == 5 -o $choice == 6 ]; then
        clear    # Clear Screen;
        echo "Starting Process of Listing Account ...";
        displayUserAccount

elif [ $choice == 7 ]; then
        echo "Scripted Terminated With Status: ${?} ...";
        exit 0

else
        echo "Invalid input is given from the menu";
        exit 1
fi