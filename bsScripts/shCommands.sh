#!/bin/bash

## Author: Neeraj Singh Junior;
## Objective: Exploring the commands input and output
## in the borne shell scripts;

## Uptime commands
# uptime=`uptime`
# echo "$uptime"

## Listing directory;
# search_dir="/media/devil/Microsoft\ Sexy/Xerus/Americano\ Style"
# `cd /media/devil/Microsoft\ Sexy/Xerus/Americano\ Style`
# list=`ls -l | grep -i cute* | more`
# for $item in $search_dir
# do 
#     echo "$item"
# done

## listin users;
# var_a=`id`
# var_b=`date; uptime; id`
# echo $var_a, $var_b
# echo $var_b

## Checking null conditions;

# >> ${var:-word} >> if var is null, only when word is substitute;
# echo ${var:-"Variable is not set"}
# echo "1 - Value of var is ${var}"

## >> ${var:=word} >> if var is null, then word is set to var;
# echo ${var:="Variable is not set"}
# echo "2 - Value of var is ${var}"

## >> ${var:+word} >> if var is set, then word is subtitute for var.
# unset var
# echo ${var:+"This is default value"}
# echo "3 - Value of var is $var"

## >> ${var:?word} >> if var is null, then print the standard format error;
# echo ${var:?"Print this message"}
# echo "5 - Value of var is ${var}"

