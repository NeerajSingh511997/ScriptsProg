#!/bin/bash

## Author: Neeraj Singh Junior;
## objective: Exporing the syntax and the use of arrays
## in the shell scripting programming;

# echo "`basename ${0}`"
# echo $1
# echo $2
# echo $3

itr=0
len=$#
array=()
newArray=()

# Method 1: While Loop
while [ $itr -lt $len ]
    do 
        array[$itr]=${itr}
        itr=`expr $itr + 1`
    done

echo "$@"
itr=0

# Method 2: For Loop
for x in $@
    do 
        newArray[$itr]=$x
        itr=`expr $itr + 1`
    done

echo "$@"
arrlen=${#array[@]}
# arrlen=${array[@]}
echo ${arrlen}



# echo "${array[@]}"




# array=( one two three )
# files=( "/etc/passwd" "/etc/group" "/etc/hosts" )
# limits=( 10, 20, 26, 39, 48)

# printf "%s\n" "${array[@]}"
# printf "%s\n" "${files[@]}"
# printf "%s\n" "${limits[@]}"