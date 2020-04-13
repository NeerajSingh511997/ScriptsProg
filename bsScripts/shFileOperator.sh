#!/bin/bash

## Author: Neeraj Singh Junior;
## Objective: Checking if the input argument 
## is a files of a directory;

## >> basename is a user type keyword used to return filename from path;
## >> for example,
## >>   basename /var/www/html/modules/scripts/bash/shFile.sh
## >>       -> shFile.sh

## Beginning;
options="$1"
case ${options} in
    -f)
        file="$2"
        if [ -f $file ]
            then 
                echo "${file} Found in Current Directory ..."
                echo "File Permission ..."

                ## Method 1: Ternary Operator;
                [ -r ${file} ] && echo "Read: True" || echo "Read: False"
                [ -w ${file} ] && echo "Write: True" || echo "Write: False"
                [ -x ${file} ] && echo "Execute: True" || echo "Execute: False"

                ## Method 2: Ordinary If and Else;
                # if [ -r ${file} ]
                #     then 
                #         echo "Read: True"
                # if [ -w ${file} ]
                #     then 
                #         echo "Write: True"
                # if [ -x ${file} ]
                #     then 
                #         echo "Execute: True"
                # fi  # end of 1 > if 
                # fi  # end of 2 > if
                # fi  # end of 3 > if
        else
            echo "${file} Not Found in Current Directory ..."
        fi
        ;;
    -d) 
        dir="$2"
        if [ -d $dir ]
            then    
                echo "${dir} Found in Current Directory ..."
                echo "File Permission ..."

                ## Method 1: Extra-Ordinary Ternary Operator;
                [ -r $dir ] && echo "Read: True" || echo "Read: False"
                [ -w $dir ] && echo "Write: True" || echo "Write:False"
                [ -x $dir ] && echo "Execute: True" || echo "Execute: False"

                # Method 2: Ordinary If and Else;
                # if [ -r ${dir} ]
                #     then 
                #         echo "Read: True"
                # if [ -w ${dir} ]
                #     then 
                #         echo "Write: True"
                # if [ -x ${dir} ]
                #     then 
                #         echo "Execute: True"
                # fi  # end of 1 > if 
                # fi  # end of 2 > if
                # fi  # end of 3 > if
        else    
            echo "${dir} Not Found in Current Directory"
        fi
        ;;
    *)
        echo "`basename $0`: usage: [ -f file ] || [ -d directory ]"
        exit 1  # Exit program abnormally;
        ;;
esac

echo "Exit: $?"
## End;