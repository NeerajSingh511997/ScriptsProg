#| #!/bin/bash


#| Author: Neeraj Singh Junior
#| Objective: Open default google chrome tab with the download tab pinned.
#| Usage: FILENAME [-a|-b] [PARAMETERS]
#|        -c  OPTIONS your_message.


# Main Control Statements;
if [[ `id -u` == 0 ]]; then 
    echo "|Err| Script should not run as root or sudo."
    exit 1;
fi

# Usgage of the Script;
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

# Open Google Chrome;
function openChrome() {
    if [[ $OPEN_STATUS="TRUE" ]]; then 
        # Opening Google Chrome in background;
        echo "`google-chrome --incognito`" > /dev/null 2>&1 &
        if [ $? -ne 0 ]; then 
            log -e "Google Chrome failed to open ..."
            exit 1
        fi
        sleep 8s
        # Press key Combinations;
        xdotool key ctrl+j
        log "Google Chrome just opened for you ..."
    fi
    return 0;
}

# Open Google Chrome;
function defChrome() {
    if [[ $DEFAULT_STATUS="TRUE" ]]; then 
        echo "Hello World";
    fi
    return 0;
}

# Open Google Chrome;
function resetChrome() {
    if [[ $RESET_STATUS="TRUE" ]]; then 
        echo "Hello World";
    fi
    return 0;
}

# Main Control Statements;
while getopts onr option
do 
    USERNAME=$(id -un)
    case $option in
        o)
            OPEN_STATUS="TRUE";
            log -p "Opening your style google chrome for ${USERNAME}";
            openChrome;
            exit 0;
            ;;
        n)
            DEFAULT_STATUS="TRUE";
            defaultParameter="${OPTARG}";
            log -p "Opening default google chrome for ${USERNAME}";
            defChrome;
            exit 0;
            ;;
        r)
            RESET_STATUS="TRUE";
            defaultParameter="${OPTARG}";
            log -p "Reseting google chrome for ${USERNAME}";
            resetChrome;
            exit 0;
            ;;
        ?) 
            log -e "Invalid Option is SELECTED";
            usage;
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