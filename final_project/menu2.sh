#!/bin/bash 

PS3="DB connected ==> enter your choice:"
dbpath="$(pwd)/../DBMS/$db"
#holding a reference to the directory containing the scripts
scriptpath="$(pwd)"

#going into the db directory
cd $dbpath

while true
do

	select c in "Create Table" "List Tables" "Drop" "Insert into table" "Delete from table" "update into table" "Select from table" "Live preview" "Back to main menu"
	do
	case $REPLY in 
		1) hline "creating table"
		   read -p "enter the name of table : " t_name
		   . $scriptpath/name_validation.sh $t_name
		   if [ $? ]
		   then 
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
		2) hline "listing tables" 
			success $(ls $dbpath)
			hline "%14s"
			break
			;;

		3) hline "dropping table"
			warning "Warning: The table and its contents will be deleted permanently"
			read -p "enter the table name: " t_drop
			if [ -f $dbpath/$t_drop ]
			then
				rm $dbpath/$t_drop
				success "the table dropped successfully"
				hline "%14s"
			else
				error "Dropping error: the table doesn't exist"
				hline "%14s"
			fi
			break
		       	;; 


		4) hline "insert into table"
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

		5) hline "delete from table"
			warning "Warning: be carful with your data"
			read -p "enter the table name: " t_delete
			if [ -f $dbpath/$t_delete ]
			then 
				. $scriptpath/delete_ftable.sh $t_delete
				hline "%17s"
				#PS3="(DB connected) -> enter your choice:"
			else
				error "Deletion error: the table doesn't exist"
				hline "%17s"
			fi
			break
			;;


		6) hline "update table"
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


		7) hline "select from table"

			read -p "enter the table name: " t_select
			if [ -f $dbpath/$t_select ]
			then
				. $scriptpath/select_table.sh $t_select $dbpath
				hline "%17s"
			else
				error "selection error: the table doesn't exist"
				hline "%17s"
			fi
			break
			;;

		8) hline "live preview"
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

		9) hline "Back to Main menu"
			break 2
			hline "%17s"
			;;

		*) error "invalid input, it must be form 1 to 9" ;;

	esac
	done

done


