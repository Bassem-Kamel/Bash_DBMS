#!/bin/bash 

PS3="(DB connected) ======> enter your choice:"
dbpath="$(pwd)"

while true
do


	select c in "Create Table" "List Tables" "Drop" "Insert into table" "Delete from table" "update into table" "Select from table" "Live preview" "Back to main menu"
	do
	case $REPLY in 
		1) echo " -------------- (creating table) -----------"
		   read -p "enter the name of table : " t_name
		   . name_validation.sh $t_name
		   if [ $? ]
		   then 
			   if [ -f $dbpath/$t_name ]
			   then
				   echo "!== (Error) : this table already exists"
			   else
				   . create_table.sh $t_name
			   fi
		   fi
		   break
		       	;;
		2) echo " -------------- (listing tables) -------------" 
			ls $dbpath
			break
			;;

		3) echo " ------------ (dropping table) --------------"
			read -p "---> enter the table name :" t_drop
			if [ -f $dbpath/$t_drop ]
			then
				rm $dbpath/$t_drop
			else
				echo "!==> (dropping error) : table doesn't exist"
			fi
			break
		       	;; 


		4) echo " ------------------- (insert into table) ------------------- "
			read -p "---> enter the table name : " t_insert
			if [ -f $dbpath/$t_insert ]
			then
			       . insert_intable.sh $t_insert	

			else
				echo "!==> (insertion error) : table doesn't exist"
			fi
			break
			;;	




		5) echo " ------------------- (delete from table) -----------------"
			read -p "---> enter the table name : " t_delete
			if [ -f $dbpath/$t_delete ]
			then 
				. delete_ftable.sh $t_delete
				PS3="(DB connected) =====> enter your choice:"
			else
				echo "!===> (deletion error) : table doesn't exist"
			fi
			break
			;;


		6) echo " -------------- (update into table) ----------------"
			read -p "---> enter the table name : " t_update
			if [ -f $dbpath/$t_update ]
			then 
				. update_table.sh $t_update
			else
				echo "!==> (update error) : table doesn't exist"
			fi
			break
			;;


		7) echo " ------------------ (select from table) ---------------- "

			read -p "---> enter the table name : " t_select
			if [ -f $dbpath/$t_select ]
			then
				. select_table.sh $t_select
			else
				echo "!==> (selection error) : table doesn't exist"
			fi
			break
			;;

		8) echo " ------------------ (live preview) ----------------"
			read -p "enter the table name : " t_preview
			if [ -f $dbpath/$t_preview ]
			then
				gnome-terminal -- live_preview.sh $t_preview $dbpath > /dev/null
			else
				echo "!==> (preview error) : table doesn't exist"
			fi
			break
			;;

		9) echo " --------------- (Back to Main menu) ---------------"
			break 2
			;;

		*) echo "!=== (invalid input) , it must be form 1 to 9 " ;;

	esac
	done

done


