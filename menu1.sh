#!/bin/bash 

PS3="enter your choice:"
path="/home/bassem/iti/DBMS"

select c in "Create DB" "List Databases" "Connect" "Drop"
do
	case $REPLY in 
		1) echo " creating -----------"
		   . /home/bassem/iti/name_validation.sh
		   if [ $? ]
		   then 
			   mkdir $path/$name
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
				echo "database doesn't exist"
			fi
		       	;;
		4) echo " dropping --------------"
			read -p "enter the database name :" db_drop
			cd $path
			rm -r $path/$db_drop
		       	;; 

		*) echo "invalid input" ;;

	esac
done


