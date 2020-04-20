#!/bin/bash

# path=${*}
# if [[ $(tail -c1 $path) == '/' ]]; then 
#     echo '/'
# else
#     echo 'No'
# fi

## Accessing files using for loop;
# USER_LIST="data/UserList.txt";
# cat /etc/passwd | cut -d ':' -f 1 > $USER_LIST;
# for USER in "$(cat $USER_LIST)"
# do
#     if [[ ${USER} -eq 'root' ]]; then 
#         log "${USERNAME} already Exist in this fucking System";
#         exit 1;
#     else
#         echo "${USER}";
#     fi
# done