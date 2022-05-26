#! /bin/bash

table=$1
#dbpath=$2

select c in "Select all" "Select specific column"
do
    case $REPLY in
        1) echo "--------------------------- $table ---------------------------"
        #column displays info in tabular format using -t option. the -s option specifies the delimeter
        head -1 $dbpath/$table | column -t -s ":"
        echo "--------------------------------------------------------------"
        tail -n+2 $dbpath/$table | column -t -s ":"
        ;;

        2) read -p "enter the name of column: " columnName
        #checking if the column exists in the first row of the file > aka the columns
        if head -1 $dbpath/$table | grep -q $columnName
        then
        #getting the first line then piping it to sed to repllace the delimeter with \n
        # so that every word in the head is on new line then piping it to nl to add line numbers
        # then searching for the desired column and lastly piping to cut so we can get the column number
            colNum=$(head -1 $dbpath/$table | sed 's/:/\n/g' | nl | grep $columnName | cut -f 1)
            echo "--------------------------- $table ---------------------------"
            cut -d: -f $colNum $dbpath/$table | head -1
            echo "--------------------------------------------------------------"
            cut -d: -f $colNum $dbpath/$table | tail -n+2
            echo "--------------------------------------------------------------"

        else
            echo "the column name can't be found..."
        fi
        ;;
        *) echo "invalid input" ;;
	esac
done
