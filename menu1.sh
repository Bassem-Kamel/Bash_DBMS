#!/bin/bash 

PS3="enter your choice:"

dir_name="bassem"
select c in "Create DB" "List Databases" "Connect" "Drop"
do
	case $REPLY in 
		1) echo " creating -----------"
		   . ./name_validation.sh
		   if [ $? ]
		   then 
			   mkdir /home/bassem/iti/DBMS/$name
		   fi
		       	;;
		2) echo " listing ------------" 
			ls /home/bassem/iti/DBMS
			;;

		3) echo " connecting ----------"
			cd /home/bassem/iti/DBMS/$dir_name
			pwd
		       	;;
		4) echo " dropping --------------"
			cd /home/bassem/iti/DBMS
			rm -r /home/bassem/iti/DBMS/$dir_name
		       	;; 

		*) echo "invalid input" ;;

	esac
done


