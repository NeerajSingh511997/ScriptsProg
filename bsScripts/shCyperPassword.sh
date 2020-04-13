#!/bin/bash

## Author: Neeraj Singh Junior;
## Objective: It used to generate cryptographic encryptions;

function generatePassword() {
    # if any cli argument;
    local string=${1};
    # all chunk string;
    chunkStr=$(echo "${string:=qwertyuio7890pASDFGHJKLzxcv!@#$~%^&*()bnmQWERTYUIOPasd123456fghjklZXCVBNM}")
    # randomize string;
    local string=$(echo "$chunkStr" | fold -w8 | shuf | head -c8);
    # alphanumeric sha1sum with date command;
    alphaNum=$(echo date +%s%N${RANDOM}${RANDOM} |sha1sum | head -c8);
    # final password
    password=$(echo "${string}${alphaNum}");
    # password=$(echo "${string}${c1}${alphaNum}${c2}");
    echo $password;
    if [ $? -ne 0 ]; then
        echo "Authentication Token Generation Failed with ${?}";
        echo "Rolling back changes ...";
        exit 0;
    fi
    return 0;
}

# Call For Password Generation;
read -p "Enter Random String: " string;
password=$(generatePassword $string);
echo "${password}";