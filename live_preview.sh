#! /bin/bash

table=$1
dbpath=$2

while true;
    do
    clear
    date
    echo "--------------------------- $table ---------------------------"
    #column displays info in tabular format using -t option. the -s option specifies the delimeter
    head -1 $dbpath/$table | column -t -s ":"
    echo "--------------------------------------------------------------"
    tail -n+2 $dbpath/$table | column -t -s ":"
    sleep 3
done