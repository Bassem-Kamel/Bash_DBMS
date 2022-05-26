#!/bin/bash 

PS3="(Main menu)---> enter your choice:"
path="$(pwd)/../DBMS"

while true
do


	select c in "Create DB" "List Databases" "Connect" "Drop" "Done"
	do
	case $REPLY in 
		1) echo "-------------- (creating DB) ------------------"
		   read -p "----> enter the database name : " db_name
		   . name_validation.sh $db_name
		   if [ $? ]
		   then 
			   if [ -d $path/$name ]
			   then
				   echo "==! (Error) : this database already exists---- "
			   else
				   mkdir $path/$name
			   fi
		   fi
		   break
		       	;;
		2) echo "------------------------- (listing) ----------------------" 
			ls $path
			break
			;;

		3) echo "--------------------- (connecting) ---------------------"
			read -p "---> enter the database name : " db
			if [ -d "$path/$db" ]
			then
				cd $path/$db
				. menu2.sh
				PS3="(Main menu)---> enter your choice:"
			else
				echo "!==> (connection error) : database doesn't exist"
			fi
			break
		       	;;
		4) echo "------------------------(dropping) ------------------------"
			read -p "enter the database name :" db_drop
			if [ -d $path/$db_drop ]
			then
				cd $path
				rm -r $path/$db_drop
			else
				echo "!==> (dropping error) : database doesn't exist"
			fi
			break
		       	;; 

		5) echo " -------------------------(Done) --------------------------"
			break 2
			;;
		*) echo "(!) invalid input, please choose from 1 to 5" ;;

	esac
	done
done

