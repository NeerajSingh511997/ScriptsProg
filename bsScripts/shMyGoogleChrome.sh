#| #!/bin/bash


#| Author: Neeraj Singh Junior
#| Objective: Open default google chrome tab with the download tab pinned.
#| Usage: FILENAME [-a|-b] [PARAMETERS]
#|        -c  OPTIONS your_message.


# Usage of script;
function usage() {

}

# Logging statements;
function log() {
    # Error statement;
    if [[ ${1} == '-e' ]]; then 
        echo "|Err| ${2}";
    # Process Execution;
    elif [[ ${1} == '-p' ]]; then    
        echo "|>>| ${2}";
    # Comment Format;
    elif [[ ${1} == '-c' ]]; then
        echo "#| ${2}";
    # Normal print statement;
    else
        echo "|>| ${1}";
    fi
}

# Main Control Statements;
if [[ `{UID}` != 0 ]]; then 
    echo "hello world"
else
    log -e "Script should not run as root."
    usage;
fi