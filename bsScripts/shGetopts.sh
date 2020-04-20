#!/bin/bash

## Author: Neeraj Singh Junior;
## Objective: Exploring the getopts commands in the development;
##  >> generate random password;
##  >> user can set the password length
##  >> user can add a special character;

# Set a default password length;
LENGTH=48;

# Display usage of the script;
function usage() {
    echo "Usage: ${0} [-vs] [-l length]" >&2;
    echo "Generate a Random Password.";
    echo "  -l LENGTH Specify the password length.";
    echo "  -s        Append a special character.";
    echo "  -l        Increase verbosity";
    exit 1;
}

# Enhance verbosity of script;
function verbosity() {
    if [[ $VERBOSE_CHECK == "TRUE" ]]; then 
        echo "VERBOSE ";
    fi
    return 0;
}

# Generate Password for this script;
function generatePassword() {
    local allChars char password;
    password=$(date +%s%N${RANDOM}${RANDOM}${RANDOM} | sha256sum | head -c${LENGTH})
    # Checking for Special Char    
    if [[ $PASSWORD_CHECK == "TRUE" ]]; then 
        echo "${password}";
    elif [[ $SPECIAL_CHARACTER_CHECK == "TRUE" ]]; then 
        allChars="!@#$%^&*()+=";
        char=$(echo "${allChars}" | fold -w1 | shuf | head -c1);
        echo "${password}${char}";
    fi
    return 0;
}

# logging the process of the script;
function log() {
    local message=${*};
    echo "${message}";
    return 0;
}

# Main Program calls;
while getopts vl:s OPTION
do
    case ${OPTION} in
        v) 
            VERBOSE_CHECK="TRUE";
            log "Verbose mode activated ...";
            verbosity;
            ;;
        l) 
            log "Generating random password ...";
            PASSWORD_CHECK="TRUE";
            LENGTH="${OPTARG}";
            generatePassword;
            ;;
        s)
            log "Generating Random Password with Special Character...";
            SPECIAL_CHARACTER_CHECK="TRUE";
            generatePassword;
            ;;
        ?)
            echo "Invalid Option." 1>&2;
            usage   # Print usage of this script;
            exit 1;
            ;;
    esac
done