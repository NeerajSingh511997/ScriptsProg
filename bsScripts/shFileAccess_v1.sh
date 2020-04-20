#!/bin/bash

## Author ...
## Neeraj Singh Junior;
## Objective ...
## Rename all files inside folders;


# Display Menu Of the Script;
function makeMenu() {    
    echo -e "\n"
    echo "|>>|_Hello & Welcome, `whoami` ...";
    echo " ____________________________________________";
    echo "|__|_Account Types availables ________________|";
    echo "|1.|_Rename Files Of Current Directory. ______|";
    echo "|2.|_Move Files In Any Directory. ____________|";
    echo "|3.|_Delete All Files or Folder. _____________|";
    echo "|4.|_List Files or Folder. ___________________|";
    echo "|5.|_Search For a Files. _____________________|";
    echo "|6.|_Exit. ___________________________________|";
    echo "|__|__________________________________________| "
    echo -e "\n"
    read -p "|>>|_Your Choice: " choice;
    if [ ${?} -ne 0 ]; then 
        echo "Exception interruption at menu input ...";
        exit 1
    fi
    return 0;
}

# Renaming All files;
function renameFiles() {
    local ext path check newName filename;
    read -p "Favourite Word: " filename;
    read -p "Where To Look For Files : " path;
    # Validating the input;
    $check= $(echo "${path}" | tail -c1);
    if [[ $check == *['!'@\$%^\&*()_+]* ]]; then 
        echo "${path}: Invalid Input Identifier in path"
        echo "Script Terminated with 1"
        exit 1;
    elif [[ $check == '/' ]]; then
        echo "${path}: Path can't end with / operator"
    fi
    # check for relative and absolute path;
    for file in $path/*
    do  
        count=0;
        ext=$(echo "${file}" | tail -c4);
        newName=$(echo "${filename}_${count}.${ext}");
        echo "${newName}";
        mv "${file}" "${path}/${newName}"
        (( count++ ));
    done
    # Capture log;
    if [ $? -ne 0 ]; then   
        echo "Something went wrong while renaming files ...";
        error=`/sbin/modprobe -n -v hfsplus 2>&1`;
        echo "Error: ${error}";
        echo "Script Terminated: ${?}";
        exit 1;
    fi
    return 0;
    
}  


# Main Conditional Program Execution Calls;
# makeMenu;
# if [ $choice == 1 ]; then 
#         clear    # Clear Screen;
#         echo "Starting Process Of Renaming Files ...";
#         renameFiles;

# elif [ $choice == 2 ]; then
#         clear    # Clear Screen;
#         echo "Starting Process Of Moving Files ...";
#         movingFiles; 

# elif [ $choice == 3 ]; then
#         clear    # Clear Screen;
#         echo "Starting Process of Deleting Files or Folder ...";
#         deleteFiles;

# elif [ $choice == 4 ]; then
#         clear    # Clear Screen;
#         echo "Starting Process of Listing Files or Folder ...";
#         listingFiles;

# elif [ $choice == 5 ]; then
#         clear    # Clear Screen;
#         echo "Starting Process of Searching File or Folder ..";
#         searchFiles;

# elif [ $choice == 6 ]; then
#         echo "Scripted Terminated With Status: ${?} ...";
#         echo "Thank You :-)";
#         exit 0;

# else
#         echo "Invalid input is given from the menu";
#         exit 1
# fi


## Testing;
renameFiles;