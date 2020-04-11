#!/bin/bash



## Function Defination Style 1
# function myfunc()
# {
#     local  a='value a'
#     local  b='value b'
#     # echo "${a} ${b}"
#     echo "${a}"
#     echo "${b}"
# }

# # Method call: 1
# result=$(myfunc)
# # Method call: 2   
# # result=`myfunc`
# echo $result


## Function Defination Style 2;
# function myfunc() {
#     local  __resultvar=$1
#     local  myresult='jihyo'
#     eval $__resultvar="${myresult}"
#     # eval $__resultvar="${myresult}"
#     # eval $__resultvar="'$myresult'"
# }

# myfunc neeraj
# echo $neeraj


## Function Defination Style 3;
# function myfunc() {
#     local  __result=$1
#     local  myresult='some value'
#     eval $__result="'$myresult'"
# }

# myfunc result
# echo $result

## Function Defination Style 4;
# function myfunc() {
#     local array=("neeraj", "NeerajSingh@9", "Neeraj Singh");
#     echo "${array[@]}";
# }

# myArray=$(myfunc);
# echo "$myArray";
# echo "${#myArray[@]}";
# echo "${myArray[0]}";
# echo "${myArray[1]}";   
# echo "${myArray[2]}";


## Function Defination Stle 5;
function myfunc() {
    local choice;
    print --"text/plain" "HEllo World";
    read -p "Your Choice: " choice
    echo $choice;
}

choice=$(myfunc);
print --"text/plain" "${choice}";