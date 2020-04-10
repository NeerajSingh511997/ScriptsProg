#!/bin/bash

## Author: Neeraj Singh Junior;
## Objective: Loops are used for iteration in shell
## script. Loops includes - for, while, select, until

## Select Loop
itr=0
drinks=()
echo "Tell me, How many drinks you like ?"
read count
while [ $itr -lt count ]
    do
        echo "Hello World"
    done
# Select Loop > end;