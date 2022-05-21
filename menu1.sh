#!/bin/bash 

PS3="enter your choice:"
path="$(pwd)/../DBMS"

select c in "Create DB" "List Databases" "Connect" "Drop"
do
	case $REPLY in 
		1) echo " creating -----------"
		   . $(pwd)/name_validation_final.sh
		   echo "<< $? >>"
		   if [ $? ]
		   then 
			   if [ -d $path/$name ]
			   then
				   echo "- Error : this database already exists"
			   else
				   mkdir $path/$name
			   fi
		   fi
		       	;;
		2) echo " listing ------------" 
			ls $path
			;;

		3) echo " connecting ----------"
			read -p "enter the database name : " db
			if [ -d "$path/$db" ]
			then
				cd $path/$db
				pwd
				cd $path
			else
				echo "!==> connection error : database doesn't exist"
			fi
		       	;;
		4) echo " dropping --------------"
			read -p "enter the database name :" db_drop
			if [ -d $path/$db_drop ]
			then
				cd $path
				rm -r $path/$db_drop
			else
				echo "!==> dropping error : database doesn't exist"
			fi
		       	;; 

		*) echo "invalid input" ;;

	esac
done


