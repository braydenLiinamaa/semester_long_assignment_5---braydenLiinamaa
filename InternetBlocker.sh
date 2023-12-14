#!/bin/bash

count=0 #for final output with num of IT members

#uses IFS to split getent output into only names of IT department
while IFS=":" read -r group password number list; do
    while IFS="," read -ra names; do
	for i in ${names[@]}; do
		#loops to allow each IT member to access incoming HTTPS packets
        	iptables -A OUTPUT -p tcp --dport 443 -m owner --uid-owner $i -j ACCEPT
		((count++)) #increments with each IT member
	done
    done <<< "$list"
done < <(getent group IT)

#allows access to local web server
iptables -A OUTPUT -p tcp --dport 443 -d 192.168.2.3 -j ACCEPT

#drops all HTTP and HTTPS packets
iptables -t filter -A OUTPUT -p tcp --dport 80 -j DROP
iptables -t filter -A OUTPUT -p tcp --dport 443 -j DROP

#leaves message before exiting
echo "$count user(s) were granted internet access."
