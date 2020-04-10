#!/bin/bash

## Author: Neeraj Singh Junior;
## Objective: Check if the users is of id 1000 or a root
## user and according to the exit script;

# Checking User_ID of Existing User;
current_uid=$UID
user_name=`id -un`

# Checking if user is accessible ;
if [ "${?}" -eq 0 ]
    then 
        if [ $current_uid -eq 1000 ]
            then 
                echo "Welcome, ${user_name}"
        elif [ $current_uid -eq 0 ]
            then         
                echo "Welcome, Super User(${user_name})"
        else
            
                echo "Sorry, Restricted User !"
                echo "Exiting ..."
                exit 1
        fi # End child if;
else    
    echo "Something went wrong ..."
    exit "Terminating Status: $?"

fi # end parent if;
# Exit Successfully;
exit 0        
