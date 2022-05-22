#!/bin/bash 

PS3="DB connected ==> enter your choice:"
dbpath="/home/bassem/iti/DBMS/$db"

select c in "Create Table" "List Tables" "Drop"
do
	case $REPLY in 
		1) echo " -------------- creating table -----------"
		   read -p "enter the name of table : " t_name
		   . name_validation.sh $t_name
		   if [ $? ]
		   then 
			   if [ -f $dbpath/$t_name ]
			   then
				   echo "- Error : this table already exists"
			   else
				   . create_table.sh $t_name
			   fi
		   fi
		       	;;
		2) echo " ----------listing tables ------------" 
			ls $dbpath
			;;

		3) echo " -------- dropping table --------------"
			read -p "enter the table name :" t_drop
			if [ -f $dbpath/$t_drop ]
			then
				rm $dbpath/$t_drop
			else
				echo "!==> dropping error : table doesn't exist"
			fi
		       	;; 

		*) echo "invalid input" ;;

	esac
done


