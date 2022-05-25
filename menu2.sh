#!/bin/bash 

PS3="DB connected ==> enter your choice:"
dbpath="$(pwd)/../DBMS/$db"
#holding a reference to the directory containing the scripts
scriptpath="$(pwd)"

#going into the db directory
cd $dbpath

echo "connected to database $db"
select c in "Create Table" "List Tables" "Drop" "Select Table" "Live Preview Table"
do
	case $REPLY in 
		1) echo " -------------- creating table -----------"
		   read -p "enter the name of table : " t_name
		   . $scriptpath/name_validation.sh $t_name
		   if [ $? ]
		   then 
			   if [ -f $dbpath/$t_name ]
			   then
				   echo "- Error : this table already exists"
			   else
				   . $scriptpath/create_table.sh $t_name
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
				#removing the table file
				rm $dbpath/$t_drop
				#removing the meta file
				rm $dbpath/.$t_drop.meta
			else
				echo "!==> dropping error : table doesn't exist"
			fi
		    ;;

		4) echo " -------- select table --------------"
			read -p "enter the table name :" t_name
			if [ -f $dbpath/$t_name ]
			then
				. $scriptpath/select_table.sh $t_name $dbpath
			else
				echo "!==> selection error : table doesn't exist"
			fi
		    ;;
		5) echo " -------- live preview table --------------"
			read -p "enter the table name :" t_name
			if [ -f $dbpath/$t_name ]
			then
				. $scriptpath/live_preview.sh $t_name $dbpath
			else
				echo "!==> selection error : table doesn't exist"
			fi
		    ;;
		*) echo "invalid input" ;;

	esac
done


