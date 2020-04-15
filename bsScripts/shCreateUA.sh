#!/bin/bash

## Author: Neeraj Singh Junior;
## Objective: Creative user account in the linux shell of 
## non-sudo group
## Parameter: username, passwd, description is required as command line !

# Executing on sudo priveledges;
if [ `whoami` != root ]; then
    echo "Usage: `basename ${0}` file must run with Sudo or Root!";
    exit 1;
fi

# Script User Account Creation;
if [[ ${#} > 0 ]]; then
    # Ask type of A/C;
    username=${1};
    shift;  # Popping the cli-argument;
    comment=${@}
    password=$(echo $data +%s%N{RANDOM}{RANDOM} | sha1sum | head -c16);
    # Add user without home directory;
    useradd -c "${description}" -p ${password} -M ${username};
    # Expire Default password;
    echo "Authentication Token Updated Successfully!";
    echo "Password Should Update on First Login!"
    passwd -e "${username}";
    
    # Error log;
    if [ ${?} -nq 0 ]; then
        echo "Authentication Token Generation Unsuccessfull";
        error=`/sbin/modprobe -n -v hfsplus 2>&1`;
        echo "$error";
        deluser --remove-home ${username}
        echo "Rolling Bank changes";
        exit 1
    fi  
    # account details;
    echo "Account: ${username} Created Successfully";
    echo `cat /etc/passwd | grep ${username}`;
    echo "UserName: ${username}";
    echo "Host IP: `hostname -i`";
    echo "Host ALL IP: `hostname -I`";
    echo "Host Details ...";
    echo "`hostnamectl`";
    exit 0;   

else
    echo "Usage: `basename ${0}` file in USER_NAME [COMMENT].";
    echo "Execution halted with ${?}"
    exit 1;
fi

exit 0