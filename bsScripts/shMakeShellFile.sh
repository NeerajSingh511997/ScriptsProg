#!/bin/bash

## > Author: Neeraj Singh Junior;
## > Objective: To create a shell create files with the execute
## permission for root only;
## > Parameters: filename - of type string;


filename=${*};
if [[ ${#} -ne 0 ]]; then     
    touch "${filename}" && chmod u+x "${filename}";
    if [[ $? -ne 0 ]]; then
        error=`/sbin/modprobe -n -s -v hfsplus 2>&1`;
        echo "$error";
        echo "Process interrupted ...";
        exit 1;
    fi
    exit 0;

else
    echo "Usage: '`basename ${0}`' FILENAME";
    echo "Missing Required Argument ...";
    echo "Proccess interrupted ...";
    exit 1
    
fi

    