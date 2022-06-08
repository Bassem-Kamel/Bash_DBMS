#!/bin/bash 

PS3="DB connected -> enter your choice: "
dbpath="$HOME/iti/Bash_project/DBMS/$db_connect"
#holding a reference to the directory containing the scripts
scriptpath="$HOME/iti/Bash_project/final_project"

#going into the db directory
cd $dbpath
hline "welcome inside $db_connect"
while true
do

	select c in "Create Table" "List Tables" "Drop" "Insert into table" "Delete from table" "update into table" "Select from table" "Live preview" "Back to main menu"
	do
	case $REPLY in 
		1) clear
		   hline "creating table"
		   read -p "enter the name of table : " t_name
		   . $scriptpath/name_validation.sh $t_name
		   if [ $? ]
		   then 
		   		t_name=$name
			   if [ -f $dbpath/$t_name ]
			   then
				   error "Error: this table already exists"
				   hline "%14s"
			   else
				   . $scriptpath/create_table.sh $t_name $scriptpath
				   hline "%14s"
			   fi
		   fi
		   break
		       	;;
		2) clear
			hline "listing tables" 
			success $(ls $dbpath)
			hline "%14s"
			break
			;;

		3) clear
			hline "dropping table"
			success $(ls $dbpath)
			hline "%14s"
			warning "Warning: The table and its contents will be deleted permanently"
			read -p "enter the table name: " t_drop
			if [ -f $dbpath/$t_drop ]
			then
				rm $dbpath/$t_drop
				rm $dbpath/.$t_drop.meta
				success "the table dropped successfully"
				hline "%14s"
			else
				error "Dropping error: the table doesn't exist"
				hline "%14s"
			fi
			break
		       	;; 


		4) clear
			hline "insert into table"
			success $(ls $dbpath)
			hline "%14s"
			read -p "enter the table name: " t_insert
			if [ -f $dbpath/$t_insert ]
			then
			    . $scriptpath/insert_intable.sh $t_insert
				hline "%17s"
			else
				error "insertion error: the table doesn't exist"
				hline "%17s"
			fi
			break
			;;	

		5) clear
			hline "delete from table"
			success $(ls $dbpath)
			hline "%14s"
			warning "Warning: be carful with your data"
			read -p "enter the table name: " t_delete
			hline "%14s"
			if [ -f $dbpath/$t_delete ]
			then 
				. $scriptpath/delete_ftable.sh $t_delete
				hline "%17s"
				PS3="DB connected -> enter your choice: "
			else
				error "Deletion error: the table doesn't exist"
				hline "%17s"
			fi
			break
			;;


		6) clear
			hline "update table"
			success $(ls $dbpath)
			hline "%14s"
			warning "Warning: be carful with your data"
			read -p "enter the table name: " t_update
			if [ -f $dbpath/$t_update ]
			then 
				. $scriptpath/update_table.sh $t_update
				hline "%12s"
			else
				error "update error: the table doesn't exist"
				hline "%12s"
			fi
			break
			;;


		7) clear
			hline "select from table"
			success $(ls $dbpath)
			hline "%17s"
			read -p "enter the table name: " t_select
			if [ -f $dbpath/$t_select ]
			then
				. $scriptpath/select_table.sh $t_select $dbpath
				hline "%17s"
				PS3="DB connected -> enter your choice: "
			else
				error "selection error: the table doesn't exist"
				hline "%17s"
			fi
			break
			;;

		8) clear
			hline "live preview"
			success $(ls $dbpath)
			hline "%12s"
			read -p "enter the table name: " t_preview
			if [ -f $dbpath/$t_preview ]
			then
				gnome-terminal -- $scriptpath/live_preview.sh $t_preview $dbpath > /dev/null
				hline "%12s"
			else
				error "Preview error: the table doesn't exist"
			fi
			break
			;;

		9) clear
			hline "Back to Main menu"
			cd $scriptpath
			break 2
			hline "%17s"
			;;

		*) error "invalid input, it must be form 1 to 9" ;;

	esac
	done

done


