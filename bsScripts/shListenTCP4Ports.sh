#!/bin/bash

## Author: Neeraj Singh Junior;
## Objective: Listen tcp4 ports, tcp6. udp, udp6 ports


if [[ `whoami` == 'root' ]]; then
	netstat -ntulp
else
	echo "TCP and UDP 4 Listening Ports ....";
	netstat -4ntul: | grep ':' | awk '{print $4}' | awk -F ':' '{print $NF}' | sort -n
	echo -e "\n";
	echo "TCP and UDP Listening Ports ...";
	netstat -6ntul | grep ':' | awk '{print $4}' | awk -F ':' '{print $NF}' | sort -n
fi
