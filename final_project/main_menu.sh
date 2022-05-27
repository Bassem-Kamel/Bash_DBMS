#!/bin/bash 

source ./styles.sh

PS3="Main menu -> enter your choice: "
path="$(pwd)/../DBMS"

# checking if the DBMS exists in the parent folder
if [ ! -d $path ]
then
	mkdir $path
fi

while true
do

	#Main menu :
	select c in "Create DB" "List Databases" "Connect" "Drop" "Done"
	do
	case $REPLY in 
		1) hline "creating DB"
		   read -p "Enter the database name: " db_name
		   . ./name_validation.sh $db_name
		   if [ $? ]
		   then 
		   		db_name=$name
			   if [ -d $path/$db_name ]
			   then
				   error "Error: this database already exists"
				   hline "%11s" "\n"
			   else
				   mkdir $path/$db_name
				   success "DB created"
				   hline "%11s"
			   fi
		   fi
		   break
		       	;;
		2) hline "listing" 
			success $(ls $path)
			hline "%7s" "\n"
			break
			;;

		3) hline "connecting"
			read -p "Enter the database name: " db
			if [ -d "$path/$db" ]
			then
				. ./menu2.sh
				PS3="Main menu -> enter your choice: "
			else
				error "Connection error: database doesn't exist"
				hline "%10s"
			fi
			break
		       	;;
		4) hline "dropping"
			warning "Warning: be carful the database and all its contents might be deleted permanently"
			read -p "enter the database name: " db_drop
			if [ -d $path/$db_drop ]
			then
				rm -r $path/$db_drop
				success "DB dropped successfully"
				hline "%8s"
			else
				error "Dropping error: database doesn't exist"
				hline "%8s"
			fi
			break
		       	;; 

		5) hline "Done"
			break 2
			;;
		*) error "Invalid input, please choose from 1 to 5" ;;

	esac
	done
done

