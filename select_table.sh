#! /bin/bash

table=$1
dbpath=$2

select c in "Select all" "Select specific column"
do
    case $REPLY in
        1) echo "--------------------------- $table ---------------------------"
        #column displays info in tabular format using -t option. the -s option specifies the delimeter
        head -1 $dbpath/$table | column -t -s ":"
        echo "--------------------------------------------------------------"
        tail -n+2 $dbpath/$table | column -t -s ":"
        ;;

        2) read -p "enter the name of column: " column
        #checking if the column exists in the first row of the file > aka the columns
        if grep -Fxq $column $dbpath/$table
        then
            awk 'BEGIN{FS=OFS=":"} {print $1}' $dbpath/$table
        else
            echo "the column name can't be found..."
        fi
        ;;
        *) echo "invalid input" ;;
	esac
done