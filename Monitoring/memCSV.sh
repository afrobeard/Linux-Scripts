#!/bin/bash

if [ "$1" == "-h" ]
then
    echo "./memCSV <pid> <csvfile> <optional:csvfilechildren>"
elif [ "$1" == "" ]
then
    echo "./memCSV <pid> <csvfile> <optional:csvfilechildren>"
else
    for((i=1;;++i)) {
        ps -p $1 -o pid,pcpu,m_size,vsize,cmd | tail -n +2 | awk '{ $2 = $2; print }' | awk -v id=$i '{print id,$0}' | awk '{gsub(/ /,",");print}'  >> $2;
	if [ "$3" = "" ]
            then
                #Do not Run csv file generation for children without 3rd argument
                sleep 0
            else
                ps --ppid $1 -o pid,pcpu,m_size,vsize,cmd | tail -n +2 | awk '{ $2 = $2; print }' | awk -v id=$i '{print id,$0}' | awk '{gsub(/ /,",");print}'  >> $3;
        fi
        sleep 5
    }
fi
