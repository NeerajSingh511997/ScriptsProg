#!/bin/bash

## Author ...
## Neeraj Singh Junior;
## Objective ...
## Create user account with the modular shell scripting,
## modules like functions - reducing the size of code.
## Parameters ... 
## Username, Password, Description (oneline only)
## Modules ...
## makeMenu(): Display the user account menu;
## createUserAccount(): Used to create user account with or without Home Directory;
## generatePassword(): Used to generate password for account;
## backupUserAccount(): Used to backup user account;
## deleteUserAccount(): Used to delete user account with or without Home Directory;
## displayUserAccount(): Used to display or search account in the host system;

# Check, if not Sudo or Root user account;
if [ `whoami` != root ]; then
    echo "`basename {0}` Usage: Need to call Script as Sudo or Root.";
    exit 1;
fi

# Display Menu Of the Script;
function makeMenu() {    
    echo -e "\n"
    echo "|>>|_Hello & Welcome, `whoami` ...";
    echo " ____________________________________________"
    echo "|__|_Account Types availables _______________|";
    echo "|1.|_U/A With Home Directory_________________|";
    echo "|2.|_U/A Without Home Directory _____________|";
    echo "|3.|_Delete U/A with Home Directory _________|";
    echo "|4.|_Delete U/A without Home Directory ______|";
    echo "|5.|_List all the user in account ___________|";
    echo "|6.|_Search for a user account in tree ______|";
    echo "|7.|_Exit ___________________________________|";
    echo "|__|_________________________________________| "
    echo -e "\n"
    read -p "|>>|_Your Choice: " choice;
    if [ ${?} -ne 0 ]; then 
        echo "Exception interruption at menu input ...";
        exit 1
    fi
    return 0;
}

# Generate Random Password;
function generatePassword() {
    local password="${1}@${RANDOM}";
    if [ ${?} -ne 0 ]; then 
        echo "Password generation exited with status 1";
        exit 1;
    fi
    echo "$password";
    return 0;
}

# Creating User Account;
function createUserAccount() {
    if [ $choice == 1 -o $choice == 2 ]; then
        # local parameters
        local username;
        local password;
        local comment;
        # Initialization of 
        read -p "Enter your username: " username;
        read -p "Enter your fullname: " comment;
        password=$(generatePassword ${username});

        # Check if user wants home directory;
        if [ $choice == 1 ]; then
            useradd -c "${comment}" -p ${password} -m ${username};
        else
            useradd -c "${comment}" -p ${password} -M ${username}; 
        fi

        # Capturing UserAdd Command Status;
        if [ $? -ne 0 ]; then   
            echo "Error occured while adding U/A ...";
            error=`/sbin/modprobe -n -v hfsplus 2>&1`;
            echo "Error: ${error}";
            echo "Script Terminate: ${?}";
            exit 1;
        fi

        # Authentication Tokken added to account;
        echo "Authentication Token Updated Successfully ...";
        passwd -e ${username};
         # Authentication Token Error Log; 
        if [ $? -ne 0 ]; then   
            echo "Error occured while removing U/A ...";
            echo "Rolling back changes ..."
            deluser --remove-home ${username}
            error=`/sbin/modprobe -n -v hfsplus 2>&1`;
            echo "Error: ${error}";
            echo "Script Terminate: ${?}";
            exit 1;
        fi

        # Backup New User Account; 
        echo "Started Process of Backing up U/A ..."
        backupUserAccount $username $password $comment;
        echo "Account Created Successfully!";
        if [ ${?} -ne 0 ]; then 
            echo "Error occured while creating backup ..."
            echo "Rolling back changes ..."
            deluser --remove-home ${username}
            exit 1;
        fi
        
        echo "Account Credentials ..."
        echo "Username: ${username}";
        echo "Password: ${password}"
        exit 0;

    else
        echo "Abnormal Termination: Script Exited With Status 1";
        echo "Rolling back changes ...";
        exit 1;
    fi
    return 0
}

# Backup Up Account;
function backupUserAccount() {
    location='/var/www/html/scripts/bsScripts/data';
    # Backup file dump at location;
    if [ -d $location ]; then
        echo "|`date` | $1 | $2 | $3 |" >> ${location}/shUserAccount-v2.txt;
    else
        mkdir $location;
        echo "|`date` | $1 | $2 | $3 |" >> ${location}/shUserAccount-v2.txt;
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

# User Account Delete With Home;
function deleteUserAccount() {
    read -p "Enter username: " username;
    # Check if u/a remove with home directory;
    if [ $choice == 3 ]; then
        deluser --remove-home ${username}
    else
        deluser ${username}
    fi
    # Error log; 
    if [ $? -ne 0 ]; then   
        echo "Error occured while removing U/A ...";
        error=`/sbin/modprobe -n -v hfsplus 2>&1`;
        echo "Error: ${error}";
        echo "Script Terminate: ${?}";
        exit 1;
    fi
    return 0
}

# Search User Account;
function displayUserAccount() {
    # check if user wants list or search;
    if [ $choice == 5 ]; then 
        echo "All User Available On this host machine: '`hostname`'"
        echo `cut -d: -f1 /etc/passwd `;
    else
        read -p "Username: " username;
        echo `cat /etc/passwd | grep ${username}`;
        echo "UserName: ${username}";
        echo "Host IP: `hostname -i`";
        echo "Host ALL IP: `hostname -I`";
        echo "Host Details ...";
        echo "`hostnamectl`";
    fi
    # Error log; 
    if [ $? -ne 0 ]; then   
        echo "Error occured while removing U/A ...";
        error=`/sbin/modprobe -n -v hfsplus 2>&1`;
        echo "Error: ${error}";
        echo "Script Terminate: ${?}";
        exit 1;
    fi
    return 0;
}

# Display Menu;
makeMenu    
# Program Execution Calls;
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