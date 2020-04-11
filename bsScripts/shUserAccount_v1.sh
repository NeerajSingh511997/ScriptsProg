#!/bin/bash

## Author: Neeraj Singh Junior;
## Objective: Creative user account in the linux shell of 
## non-sudo group
## Parameter: username, passwd, description is required !!

# Executing on sudo priveledges;
if [ `whoami` == root ]; then
    # Ask type of A/C;
    echo "Welcome, `whoami`!";
    echo "Account Types availables ...";
    echo "1. U/A With Home Directory";
    echo "2. U/A Without Home Directory";
    echo "3. Delete U/A with Home Directory ";
    echo "4. Delete U/A without Home Directory";
    echo "5. List all the user in account";
    echo "6. Search for a user account in tree";
    read -p "Your Choice: " choice;
   
    # A/C Make Execution;
    if [ ${choice} -eq 1 -o ${choice} -eq 2 ]; then
        # Adding user without home directory;
        read -p "New Username: " username;
        read -p "New Password: " password;
        read -p "New Description: " description;
        # User Home Directory Check;
        if [ $choice -eq 1 ]; then 
            useradd -c "${description}" -p ${password} -m ${username};
        else
            useradd -c "${description}" -p ${password} -M ${username}
        fi 
        # Expire Default password;
        echo "${password}" | passwd -e "${username}";

        # Error log;
        if [ ${?} -eq 0 ]; then 
            echo "Authentication token generated Successfully";
            echo "Password must be changed at first login";
        else    
            echo "Authentication Token Generation Unsuccessfull";
            error=`/sbin/modprobe -n -v hfsplus 2>&1`;
            echo "$error";
            deluser --remove-home ${username}
            echo "Rolling Bank changes";
            exit 1
        fi
    
        echo "Account: ${username} created +d successfully ...";
        echo `cat /etc/passwd | grep ${username}`;
        exit 0;

    elif [ $choice == 3 -o $choice == 4 ]; then 
        read -p "Username: " username;
        # User Directory check of deletion;
        if [ $choice == 3 ]; then 
            deluser --remove-home ${username}
            echo "Account +d Deleted Successfully..."
        else
            deluser ${username}
            echo "Account -d Deleted Successfully..."
        fi 
        # Error log;
        if [ ${?} -ne 0 ]; then 
            error=`/sbin/modprobe -n -v hfsplus 2>&1`;
            echo "$error";
            echo "Error occured while adding users";
            echo "Rolling back changes ...";
            echo "Exit: 1"
            exit 1;
        fi 
            
    elif [ $choice == 5 -o $choice == 6 ]; then 
        # User Choice;
        if [ $choice == 5 ]; then 
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
            echo "Error occured user list can't generate."
            error=`/sbin/modprobe -n -v hfsplus 2>&1`;
            echo "$error";
            echo "Rolling back changes ..."
            echo "Exit: 1"
            exit 1
        fi 
        date=`date`;
        echo "List generated on ${date}"
        exit 0

    else    
        echo "`basename {0}`: Invalid Input";
        echo "Rolling back changes ...";
        exit 1;

    fi  # End >> nested If;
              
    # Error Log;

else
    echo "`basename $0:` file must run with sudo or root previledges.";
    exit 1;
fi

exit 0