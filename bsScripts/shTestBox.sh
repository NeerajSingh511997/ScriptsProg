#!/bin/bash

## Author: Neeraj Singh Junior;
## Objective: TestBox is script to hit and run new things
## in learning shell script

## Beginning: Functions 
# function sqaure() {
#     result = `expr $number \* $number`
#     echo "$result"
# }

# echo "Your Number: "
# read number
# $(square)
## Functions > end

## Beginning: While Loops
# a=1
# echo "Your Number... "
# read number
# while [ $a -lt 11 ]
#     do 
#         echo `expr ${number} \* ${a}`
#         a=`expr ${a} + 1`
#     done
## While Loops > end;

## Beginning: For Loop
# for FILE in $HOME/.bash*
# do
#    echo $FILE
# done

## Checking files in a directory;
# counter=0
# $myFiles="$(find /media/devil/Microsoft\ Sexy/Xerus/)" 
# clear
# for files in $myFiles
#     do 
#         echo "XXXX"
        # echo "${myFiles}"
        # echo "`expr ${counter}+1` . ${files}"
        # echo "\n"
#    done
## For Loop > end;

## Beginner: Clear Command
# echo "starting..."
# clear
# clear >$(tty)
# echo ""
# echo "End"
## Clear > end

## Beginner: Until Loop
#!/bin/sh
# a=0
# until [ ! $a -lt 10 ]
# do
#    echo $a
#    a=`expr $a + 1`
# done
## Until Loop > end

## Array Cases;
#!/bin/bash
## declare an array variable
# declare -a array=("one" "two" "three")
# array=("one" "two" "three")

# Length of array
# arraylength=${#array[@]}
# echo ${arraylength}
# echo ${array[@]}
# use for loop to read all values and indexes
# for (( i=1; i<${arraylength}+1; i++ ));
# do
#   echo $i " / " ${arraylength} " : " ${array[$i-1]}
# done

## Array Case >> end;

## Variable Identity Check;
# while true; do
#    read -r -p "Enter a string: " VAR
#    # RegEx
#    if [[ $VAR =~ [0-9] ]];then
#       echo "if block"
#    else
#       echo "else block"
#    fi
# done

## VIC >> End

## Echo Statements;
# echo "Test Case 1"
# echo "Hello"
# echo "World"

# echo "Test Case 2"
# echo "Hello World";
# echo -e "Hello World \c"
# echo "After C"
## End >> Echo Statements;

## Checking xdotool keys combination;
i=0
while [[ $i -lt 10 ]]
do
        
        xdotool key Alt+Tab
        $(( $i + 1 ))
        echo $i;
done
## End > Checking xdotool keys combination;