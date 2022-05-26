#!/bin/bash 


#change prompt
PS3="(DB connected) ======> enter your choice:"


while true
do

	# this menu provide some actions to do with tables inside certain database
	select c in "Create Table" "List Tables" "Drop" "Insert into table" "Delete from table" "update into table" "Select from table" "Live preview" "Back to main menu"
	do
	case $REPLY in 
		# Take the table name and create it after check the name validation
		1) echo " -------------- (creating table) -----------"
		   read -p "enter the name of table : " t_name
		   . name_validation.sh $t_name
		   if [ $? ]
		   then 
			   if [ -f ./$t_name ]
			   then
				   echo "!== (Error) : this table already exists"
			   else
				   . create_table.sh $t_name
			   fi
		   fi
		   break
		       	;;
		# list all tables in this database
		2) echo " -------------- (listing tables) -------------" 
			ls .
			break
			;;
		# drop table after check if it exists or not
		3) echo " ------------ (dropping table) --------------"
			read -p "---> enter the table name :" t_drop
			if [ -f ./$t_drop ]
			then
				rm ./$t_drop
			else
				echo "!==> (dropping error) : table doesn't exist"
			fi
			break
		       	;; 

		# if the table exists so we can insert values into it
		4) echo " ------------------- (insert into table) ------------------- "
			read -p "---> enter the table name : " t_insert
			if [ -f ./$t_insert ]
			then
			       . insert_intable.sh $t_insert	

			else
				echo "!==> (insertion error) : table doesn't exist"
			fi
			break
			;;	
		# delete table if we don't need it anymore
		5) echo " ------------------- (delete from table) -----------------"
			read -p "---> enter the table name : " t_delete
			if [ -f ./$t_delete ]
			then 
				. delete_ftable.sh $t_delete
				PS3="(DB connected) =====> enter your choice:"
			else
				echo "!===> (deletion error) : table doesn't exist"
			fi
			break
			;;

		# update values in the table
		6) echo " -------------- (update into table) ----------------"
			read -p "---> enter the table name : " t_update
			if [ -f ./$t_update ]
			then 
				. update_table.sh $t_update
			else
				echo "!==> (update error) : table doesn't exist"
			fi
			break
			;;

		# display some values from the table
		7) echo " ------------------ (select from table) ---------------- "

			read -p "---> enter the table name : " t_select
			if [ -f ./$t_select ]
			then
				. select_table.sh $t_select 
				PS3="(DB connected) ======> enter your choice:"
			else
				echo "!==> (selection error) : table doesn't exist"
			fi
			break
			;;
		# new feature --> live preview of the table to see all the changes live
		8) echo " ------------------ (live preview) ----------------"
			read -p "enter the table name : " t_preview
			if [ -f ./$t_preview ]
			then
				gnome-terminal -- live_preview.sh $t_preview . > /dev/null
			else
				echo "!==> (preview error) : table doesn't exist"
			fi
			break
			;;
		# back to main menu
		9) echo " --------------- (Back to Main menu) ---------------"
			break 2
			;;

		*) echo "!=== (invalid input) , it must be form 1 to 9 " ;;

	esac
	done

done


