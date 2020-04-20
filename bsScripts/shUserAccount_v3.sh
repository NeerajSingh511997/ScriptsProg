#!/bin/bash

## > Author: Neeraj Singh Junior;
## > Objective: Creative user account in the linux shell of non-sudo group.
## > Parameters ...
## >> Usage: FILENAME [-a|-c|-r|-s|-l] [USERNAME] [COMMENT]";
## >>  -a  USERNAME         Archive a user home directory;"
## >>  -c  USERNAME COMMENT Create a user account."
## >>  -s  USERNAME         Search a user account."
## >>  -r  USERNAME         Remove a user account."
## >>  -l  USERNAME         List all user account"


# Executing on sudo priveledges;
if [ `whoami` != root ]; then
    echo "Usage: `basename ${0}`, only run with Sudo or Root!";
    exit 1;
fi

# Display usage of this script;
function usage() {
    echo -e "\n";
    echo "|>>| Usage: ${0} [-a|-c|-r|-s|-l] [USERNAME] [COMMENT]";
    echo "|>>|  -a  USERNAME         Archive a user home directory;"
    echo "|>>|  -c  USERNAME COMMENT Create a user account."
    echo "|>>|  -s  USERNAME         Search a user account."
    echo "|>>|  -r  USERNAME         Remove a user account."
    echo "|>>|  -l  USERNAME         List all user account"
    exit 1;
}

# Logging steps of execution;
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

# Checking if user exist;
function isUserExist() {
    SEARCH=$(cat /etc/passwd | grep ${USERNAME});
    if [[ -z ${SEARCH} ]]; then 
        # User doesn't exist, False;
        return 1;
    fi
    # User exist, True;
    return 0
}

# User Details;
function getUserDetails() {
    local TEMP_FILE="data/temp.txt";
    local USER=$(cat /etc/passwd | grep ${USERNAME} | awk -F ':' '{print $1 "," $3 ","$4 "," $6 "," $7}');
    if [[ -z $USER ]]; then 
        log -e "Get details of User Account:'${USERNAME}' returned: NOT FOUND";
        return 1;
    fi 
    echo "$USER" > $TEMP_FILE;
    return 0;
}

# Backup user credential to csv files;
function backupAccount() {
    local DESTINATION="./data/DATA_-f_UserAccount_v3.csv";
    # Destination, Check;
    if [[ ! -e $DESTINATION ]]; then 
        touch "$DESTINATION";
        if [[ ${?} -ne 0 ]]; then
            log -e "Create of backup CSV file failed at destination ${DESTINATION}.";
            return 1;
        fi
    fi 
    local USER=$(getUserDetails);
    # Insertion inside the list;
    local TEMP_FILE='data/temp.txt';
    log -p "Generated List on `date` ..." 1>> $DESTINATION;
    if [[ -s $TEMP_FILE ]]; then
        log -p "USERNAME: ${USERNAME}" 1>> $DESTINATION;
        log -p "PASSWORD: ${PASSWORD}" 1>> $DESTINATION;
        log -p "COMMENT: ${COMMENT}" 1>> $DESTINATION;
        log -p "USER ID: `cat $TEMP_FILE | awk -F ',' '{print $2}'`" 1>> $DESTINATION;
        log -p "GROUP ID: `cat $TEMP_FILE | awk -F ',' '{print $3}'`" 1>> $DESTINATION;
        log -p "HOME DIR: `cat $TEMP_FILE | awk -F ',' '{print $4}'`" 1>> $DESTINATION;
        log -p "SHELL DIR: `cat $TEMP_FILE | awk -F ',' '{print $5}'`" 1>> $DESTINATION;
    else
        log -p "USERNAME: ${USERNAME}"; 1>> $DESTINATION;
        log -p "PASSWORD: ${PASSWORD}"; 1>> $DESTINATION;
        log -p "COMMENT: ${COMMENT}"; 1>> $DESTINATION;
    fi 
    echo -e "\n\n" 1>> $DESTINATION;
    return 0;   
}

# Creating user account;
function createAccount() {
    if [[ $CREATE_ACCOUNT_CHECK == "TRUE" ]]; then
        # Check if user exist;
        isUserExist;
        if [[ ${?} -eq 0 ]]; then 
            log -e "User '${USERNAME}' already exist on this system ...";
            usage;
            exit 1;
        fi
        # Creation Of New-Account;
        useradd -c "${COMMENT}" -p ${PASSWORD} -m ${USERNAME}
        local USERADD_STATUS=${?}
        log -m "Authentication Token is generated successfully .."
        passwd -e ${USERNAME}
        local PASSWD_STATUS=${?}
        # Checking USERADD_status of command;
        if [ $USERADD_STATUS -ne 0 -a $PASSWD_STATUS -ne 0 ]; then
            # Error Log ;
            log -e "Account Authentication updation failed ..."
            deluser --remove-home ${username}
            exit 1
        fi          
        # Display user account details;
        log -p "Account: ${USERNAME} Created Successfully";
        log -p "`cat /etc/passwd | grep ${USERNAME}`" &> /dev/null;
        log -p "Username: ${USERNAME}";
        log -p "Password: ${PASSWORD}";
        log -p "COMMENT: ${COMMENT}";
        log -p "Host IP Addr: `hostname -i`";
        log -p "Host Version: `hostname -V`";
        log -p "HOST ALL IP Addr: `hostname -I`";
        log -p "Host Details ...";
        echo "`hostnamectl`";
        # Backup up user credential in csv files;
        log -m "Starting process of backing up user account '${USERNAME}' ...";
        backupAccount;
        if [[ ${?} -ne 0 ]]; then
            log -e "Insertion of user credential into CSV file failed ..."
            exit 1;
        fi
    fi
    return 0;
}

# Archive user account;
function archiveHome() {
    if [[ $ARCHIVE_CHECK == "TRUE" ]]; then
        local SOURCE="/home/${USERNAME}";
        local DESTINATION="/home/archive";
        local BACKUP_FILE="BACKUP_${USERNAME}_`date +%d-%m-%Y_%H-%M-%S`.tar.gz";
        # Check, if user exist;
        isUserExist;
        if [[ ${?} -eq 1 ]]; then 
            log -e "Error: User '${USERNAME}' doesn't Exist";
            usage;
            exit 1;
        fi
        # User Directory, Check;
        if [[ ! -e $SOURCE ]]; then
            log -e "User '${USERNAME}' do not have a home directory. Can't Open File or Directory";
            usage;
            exit 1;
        fi
        # Backup Directory, Check;
        if [[ ! -e $DESTINATION ]]; then 
            mkdir $DESTINATION;
            if [[ $? -ne 0 ]]; then
                log -e "Error: Directory '${DESTINATION}' can't open such File or Directory";
                usage;
                exit  1;
            fi
        fi
        # Creating archive;
        tar -czvf "${DESTINATION}/${BACKUP_FILE}" --absolute-names "${SOURCE}" &> /dev/null;
        # Checking TAR_STATUS;
        local TAR_STATUS=${?};
        if [[ $TAR_STATUS -ne 0 ]]; then
            log -e "Process of archiving the home directory failed ...";
            usage;
            exit 1;
        fi
        log "Backup completed successfully!";
    fi
    return 0;
}

# Remove user account;
function removeAccount() {
    if [[ $REMOVE_ACCOUNT_CHECK == "TRUE" ]]; then
        # Check if user exist;
        isUserExist;
        if [[ ${?} -eq 1 ]]; then 
            log -e "User '${USERNAME}' doesn't Exist";
            usage;
            exit 1;
        fi
        # Remove user with all files in home directory;
        deluser --remove-home ${USERNAME};
        USERDEL_STATUS=${?};
        if [[ $USERDEL_STATUS -ne 0 ]]; then 
            log -e "Remove user account failed ...";
            exit 1;
        fi            
        log -p "Account '${USERNAME}' is removed successfully";
    fi
    return 0;
}

# Geneate Sha256Sum Password;
function generatePassword() {
    echo $(date +%s%N${RANDOM}${RANDOM} | sha256sum | head -c48);
}

# List all user accounts;
function listAccount() {
    if [[ $LIST_CHECK == "TRUE" ]]; then
        USERS=$(cat /etc/passwd | awk -F ':' '{print "USERNAME: "$1 " | UID: " $3 " | GID: "$4 " | HOME: " $6 " | SHELL: " $7}');
        USERS_STATUS=${?};
        if [[ $USERS_STATUS -ne 0 ]]; then
            log -e "Generation of user list failed ...";
            exit 1;
        fi
        echo -p "Account Generated Successfully ...\n"
        echo "${USERS}";
    fi
    return 0;
}

# Search Account;
function searchAccount() {
    if [[ $SEARCH_CHECK == "TRUE" ]]; then
        SEARCH=$(cat /etc/passwd | grep ${USERNAME} | awk -F ':' '{print "USERNAME: "$1 " | UID: " $3 " | GID: "$4 " | HOME: " $6 " | SHELL: " $7}');
        SEARCH_STATUS=${?}
        if [[ $SEARCH_STATUS -ne 0 ]]; then 
            log -e "Search list generation failed ...";
            usage;
            exit 1;
        elif [[ -z ${SEARCH} ]]; then 
            log -e "No such user '${USERNAME}' found in this system ...";
            usage;
            exit 1;
        else
            # Printing Search Results;
            log -p "Search List Generated ...";
            log -p "${SEARCH}";
        fi
    fi
    return 0;
}

# Capturing command line argument;
while getopts 'a:c:r:s:l' option
do 
    USERNAME="${OPTARG}";
    case "${option}" in
        a)
            ARCHIVE_CHECK='TRUE';
            archiveHome;
            ;;
        c)
            CREATE_ACCOUNT_CHECK='TRUE';
            shift; shift;
            COMMENT="${*}";
            PASSWORD=$(generatePassword);
            createAccount;
            ;;
        r) 
            REMOVE_ACCOUNT_CHECK='TRUE';
            removeAccount;
            ;;
        s)  
            SEARCH_CHECK='TRUE';
            searchAccount;
            ;;
        l)
            LIST_CHECK='TRUE';
            listAccount;
            ;;
        ?)
            # call to usage;
            echo "Error: Invalid Argument is parsed.";
            usage
    esac
done

# Checking for the null cli argument;
ARG=$(( $OPTIND - 1 ));
if [[ $ARG -lt 1 ]]; then 
    log -e "Missing command line argument.";
    usage      # Print Usage;
fi

# Successfull Execution;
exit 0