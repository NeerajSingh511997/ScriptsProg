#!/bin/bash

## Author ...
## Neeraj Singh Junior;
## Objective ...
## Rename all files inside folders;


count=0;
read -p "Favourite Word:  " filename;
read -p "Where to look for this: " location;

for file in $location/*
	do
		newFile=$(echo "${filename} ${count}.jpg");
		mv -- "${file}" "$location/${newFile}";
		(( count++ ));
	done
# Exit loop;