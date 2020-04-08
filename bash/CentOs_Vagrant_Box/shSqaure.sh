#!/bin/bash

## Author: Neeraj Singh Junior;
## Objective: Square a number using command
## line arguments;

## example 1
#  hello (){
#      echo "Hello World"
#  }

#  hello

## example 2;
# sqaure (){
#     temp=`expr $num \* $num`
#     return $temp
# }

# num = 12
# square

## example 3:
sample (){
    arg_1=${1:="Argument 1 Required"}
    arg_2=${2:="Argument 2 Required"}
    shift;
    shift;
    arg_3=${@:="Argument 3 Required"}
    echo "$arg_1"
    echo "$arg_2"
    echo "$arg_3"
}

echo "Script is running ..."

# arg_1=$1
# arg_2=$2
# shift;
# shift;
# arg_3=$@
# echo "$arg_1"
# echo "$arg_2"
# echo "$arg_3"
# sample Bob Harley is a russian driver, lives LA
# sample $arg_1 $arg_2 $arg_3c
sample