#!/bin/bash

## > Author ...
## Neeraj Singh Junior;
## > Objective ...
## Exploring IO Redirections in the shell scripts;
## Creation ...
## 14 April 2020;

if [[ `whoami` == root ]]; then
    # Capture ouput redirections using FD;
    echo ">>>>>>>>>>>>>>"
    file="test/read.txt"
    cat -n /etc/passwd | grep bot 1> ${file};
    cat -b $file;

    # Input Redirections using FD;
    echo "<<<<<<<<<<<<<<"
    cat -n 0< ${file};

    # Inout Redirecton using STDERR using FD
    echo ">>>>>>>>>>>>>>"
    head -n4 /etc/passwd /fakefile 2> test/error.txt

    # Redirect STDOUT and STDERR to a Fd;
    file="test/outAndErr.txt"
    # > Method 1;
    echo "Method 1 >>>>>>>>>>>>>>"
    head -n5 /etc/passwd  /etc/shadow /fakefile &> ${file}
    cat -b ${file}

    # Method 2;
    echo "Method 2 >>>>>>>>>>>>>>"
    sudo tail -n1 /etc/shadow /etc/passwd /fakefile 2>&1 | cat -n > ${file};
    cat ${file}

    # Method 3;
    echo "Method 3 >>>>>>>>>>>>>>"
    sudo tail -n1 /etc/shadow /etc/passwd /fakefile |& cat -n > ${file};
    cat ${file};

    # null device: used as dumb container;
    echo "null > output >>>>>>>>>>>>>>"
    sudo tail -n1 /etc/shadow /etc/passwd /fakefile 1> /dev/null;

    echo "null > error >>>>>>>>>>>>>>"
    sudo tail -n1 /etc/shadow /etc/passwd /fakefile 2> /dev/null;

    exit 0

else
    echo "Usage: `basename {0}` must run as Sudo or Root";
    echo 'Exiting ....';
    exit 1;
fic