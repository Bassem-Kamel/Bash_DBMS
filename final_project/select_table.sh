#!/bin/bash

table=$1
dbpath=$2
PS3="Select Menu -> enter your choice: "

while true
do

    select c in "Select all" "Select specific column" "Select specific record" "Return to previous menu"
    do
        case $REPLY in
            1) clear
            hline "$table"
            #column displays info in tabular format using -t option. the -s option specifies the delimeter
            head -1 $dbpath/$table | column -t -s ":"
            #passing number of spaces equal to the number of the chars as the table name
            hline "%${#table}s"
            tail -n+2 $dbpath/$table | column -t -s ":"
            hline "%${#table}s"
            break
            ;;

            2) clear
            head -1 $dbpath/$table | column -t -s ":"
            hline "%${#table}s"
            read -p "enter the name of column: " columnName
            #checking if the column exists in the first row of the file > aka the columns
            if head -1 ./$table | grep -q $columnName  # use -q (quiet mode)
            then
            #getting the first line then piping it to sed to repllace the delimeter with \n
            # so that every word in the head is on new line then piping it to nl to add line numbers
            # then searching for the desired column and lastly piping to cut so we can get the column number
                colNum=$(head -1 $dbpath/$table | sed 's/:/\n/g' | nl | grep $columnName | cut -f 1)
                hline "$table"
                cut -d: -f $colNum $dbpath/$table | head -1
                hline "%${#table}s"
                cut -d: -f $colNum $dbpath/$table | tail -n+2
                hline "%${#table}s"

            else
                error "Error: the column name can't be found"
            fi
            break
            ;;

            3) clear
            read -p "enter the record PK : " recordData
            # Select by primary key
            res=$(awk -F: -v p="$recordData" '{if ($1==p) print$0}'  $dbpath/$table)
            if [ $res ]
            then
                hline "$table"
                #column displays info in tabular format using -t option. the -s option specifies the delimeter
                head -1 $dbpath/$table | column -t -s ":"
                hline "%${#table}s"
                echo -e "$res\n" | column -t -s ":"
                hline "%${#table}s"
            else
                error "can't find the data you are looking for"
            fi
            break
            ;;
            4) clear
                break 2;;
            *) error "invalid input" ;;
        esac
    done
done