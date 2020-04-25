#| #!/bin/bash


#| Author: Neeraj Singh Junior
#| Objective: 
#| Parameters:
#| Usage: FILENAME [-a|-b] [PARAMETERS]
#|        -c  OPTIONS your_message.


# Usage print of Scripts;
function usage() {
    echo "";
    log "Your Message ...";
    log "Usage: `basename ${0}` OPTION";
    log "        -OPTION    your option message.";
    log "Exiting ...";
    exit 0;
}

# Logging print statements;
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
while getopts ab: option
do 
    case $option in
        a)
            STATUS_A="TRUE";
            log -p "Your Process A is SELECTED";
            ## Function call here
            exit 0;
            ;;
        b)
            STATUS_B="TRUE";
            defaultParameter="${OPTARG}";
            log -p "Your Process_B is SELECTED!";
            ## Function call here
            exit 0;
            ;;
        ?) 
            log -e "Invalid Option is SELECTED";
            exit 0;
    esac
done

# Check for required paramters;
PARAM=$(( OPTIND - 1 ))
if [[ $PARAM -lt 1 ]]; then
    log -e "Missing Required Paramters."
    usage;
    exit 1;
fi