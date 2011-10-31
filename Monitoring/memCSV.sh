#!/bin/bash

if [ "$1" == "-h" ]
then
    echo "./memCSV <pid> <csvfile>"
else
    for((i=0;;++i)) {
        ps -p $1 -o pid,pcpu,m_size,vsize | tail -n 1 | awk '{ $2 = $2; print }' | awk '{gsub(/ /,",");print}' >> $2;
        sleep 5
    }
fi
