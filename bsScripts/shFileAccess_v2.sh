#!/bin/bash

## Author ...
## Neeraj Singh Junior;
## Objective ...


# Printing usage of the script;
function usage() {
    echo "usage";
    return 0;
}

# Logging script procedures;
function log() {
    local type="${1}";
    local message="${2}";
    if [[ ${type} == '-e' ]]; then 
        echo "|Err| ${message}";
        return 0;
    elif [[ ${type} == '-m' ]]; then 
        echo "|>>| ${message}";
        return 0;
    elif [[ ${type} == '-p' ]]; then 
        echo "|>| $message";
        return 0;
    else
        echo "|>| $message";
        return 0
    fi
    return 1;
}

# Renaming files;
function renameFiles() {
    if [[ $RENAME_CHECK == 'TRUE' ]]; then 
        count=0;
        for file in ${location}
        do 
            ext=echo "${file%.*}";
            newName="${filename}_${count}.${ext}";
            mv ${file} "$location/$newName";
            $(( count + 1 ))c
        done
    fi
    return 0;
}

# Move files;
function moveFiles() {
    if [[ $MOVE_CHECK == 'TRUE' ]]; then 
        echo "Hello World";
    fi
    return 0;
}

# Delete files;
function deleteFiles() {
    if [[ $DELETE_CHECK == 'TRUE' ]]; then 
        echo "Hello World";
    fi
    return 0;
}

# listing files;
function listFiles() {
    if [[ $LIST_CHECK == 'TRUE' ]]; then 
        echo "Hello World";
    fi
    return 0;
}

# Renaming files;
function searchFiles() {
    if [[ $SEARCH_CHECK == 'TRUE' ]]; then 
        echo "Hello World";
    fi
    return 0;
}

# Program Exceution Calls;
while getopts 'r:m:d:l:s:' option
do 
    case $option in
        -r)
            RENAME_CHECK="TRUE";
            filename=${OPTARG};
            # Shifting cli-aguments;
            shift; shift;
            location=${2};
            log -p "SELECTED: Renaming files ...";
            renameFiles;
            ;;
        -m) 
            MOVE_CHECK="TRUE";
            log -p "SELECTED: Moving files ...";
            moveFiles;
            ;;
        -d)
            DELETE_CHECK="TRUE";
            log -p "SELECTED: Deleting files ..."
            deleteFiles;
            ;;
        -l)
            LIST_CHECK="TRUE";
            log -p "SELECTED: Listing files ...";
            listFiles;
            ;;
        -s)
            SEARCH_CHECK="TRUE";
            log -p "SELECTED: Searching files ...";
            searchFiles;
            ;;
        -e)
            log -p "SELECTED: Exiting ...";
            ;;
        ?)
            log -e "Invalid Option: Terminating ...";
            usage;
    esac
done

# Required argument missing log;
ARGUMENT= $(( $OPTING - 1 ))
if [[ $ARGUMENT -lt 0 ]]; then 
    log -e "Required argument is missing."
    usage;
    exit 1;
fi

