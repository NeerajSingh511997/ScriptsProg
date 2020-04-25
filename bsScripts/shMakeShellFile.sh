#!/bin/bash

## > Author: Neeraj Singh Junior;
## > Objective: To create a shell create files with the execute
## permission for root only;
## > Parameters: filename - of type string;


# Usage of the script;
function usage() {
    echo -e "\n";
    log "Creation of shell based executable file ..."
    log "Usage: `basename ${0}` [-d|-e] FILENAME"
    log "       -d,--DEFAULT_MODE    Create a normal file with log() and usage dummy method."
    log "       -e,--EXTENED_MODE    Create a extendend file with log(), usage(), control statements."
    log "       FILENAME             Refer to the name of the file with extension of shell."
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

# Default Mode file generation;
function defMode() {
    if [[ $DEFMODE_STATUS == 'TRUE' ]]; then
        if [[ ! -e $filename ]]; then 
            touch "${filename}" && chmod u+x "${filename}";
            # Status check;
            if [[ $? -ne 0 ]]; then
                log -e "${filename} can't be created."
                log -e "Process interrupted ...";
                exit 1;
            fi
            # Default Appending to the file;
            log -c "#!/bin/bash" >> "${filename}";
            echo -e "\n" >> ${filename} >> "${filename}";
            log -c "Author: Neeraj Singh Junior" >> "${filename}";
            log -c "Objective: "  >> "${filename}";
            log -c "Parameters:"  >> "${filename}";
            log -c "Usage: FILENAME [-a|-b] [PARAMETERS]"  >> "${filename}";
            log -c "       -c  OPTIONS your_message."  >> "${filename}";
            log "File Generated Successfully"
            exit 0;
        else    
            log -e "${filename} is already exist in current directory.";
            exit 1;
        fi
    else    
        log -p "Default file generation failed ...";
        exit 1;
    fi
}

# Extended Mode file generation;
function extMode() {
    if [[ $EXTMODE_STATUS == "TRUE" ]]; then 
        # Check, if File exist;
        if [[ ! -e $filename ]]; then 
            template="shDefaultTemplate.sh";
            cp "${template}" "${filename}";
            # Status check;
            if [[ $? -ne 0 ]]; then
                log -e "${filename} can't be created."
                log -e "Process interrupted ...";
                exit 1;
            fi
            log "File Generated Successfully!";
        else
            log -e "${filename} is already exist in current directory.";
            exit 1;
        fi
    else    
        echo 'Extended file generation failed ...';
        exit 1;
    fi
}

# Main Control Statements;
while getopts d:e: option
do 
    filename="${OPTARG}";
    # Control Statements;
    case "$option" in
        d)
            DEFMODE_STATUS="TRUE";
            log -p "DEFAULT file generation is SELECTED";
            defMode;
            exit 0;
            ;;
        e)
            EXTMODE_STATUS="TRUE";
            log -p "EXTENDED file generation is SELECTED";
            extMode;
            exit 0;
            ;;
        ?) 
            log -e "Invalid Option parsed.";
            usage;
            exit 1;
    esac
done

# Checking required cli-agrumnet;
PARAM=$(( $OPTIND - 1 ))
if [[ $PARAM -lt 1 ]]; then
    log -e "Missing Required Argument ..."
    usage;
    exit 1;
fi