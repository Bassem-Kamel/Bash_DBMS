#!/bin/bash

shopt -s extglob
table_name=$1

PS3="-- your choose is : "


# ----------------------------------- get primary key function -------------
function get_pk {

while true
do

                read -p "enter the PK : " pk
                findpk=$(cut -f1 -d: $table_name|grep $pk)

                case $pk in

                        +([0-9]) )
                        if [ $findpk ]
                        then
                                echo "$pk exists "
                                R=$(awk -F: -v p="$pk" '{if ($1==p) print$0}'  $table_name)
                                echo "the record : $R "
                                break
                        else
                                echo "Error : $pk doesn't exist"
                        fi
                                ;;
                *) echo "invaild PK , it must be a number"
                        ;;
                esac
 done


}




# -------------------------- menu to choose the action ------------------

select D in "Delete All" "Delete a record" "Delete a value" "Back to Menu"
do
	case $REPLY in 
		1) echo " ------deleting all values in the table -----"
		echo "" > $table_name
		;;
		2) 
		echo " ---------- delete a record -------- "

		get_pk


		sed -i "/$pk/d" $table_name
		;;

		3) 
		echo " ----------- delete a value -----------"

		get_pk

		col=$(head -1 $table_name | tr ':' ' ' | wc -w)
		while true
		do

        		read -p "enter field number : " field
        	case $field in
        	        +([0-9]) )
                	if [ $field -le $col -a $field -gt 0 ]
               		then
                	echo " valid field"
               	 	break
                	else
                	echo "invalid field"
                	fi
                        ;;
                	*)
                	echo "field must be a number"
                	;;
        	esac

		done
		old=$(echo $R | cut -f$field -d:)
		R=$(echo $R | sed "s/$old/' '/")
		sed -i "/$pk/d" $table_name
		echo $R >> $table_name
		sort -n -k1 -t: -o $table_name $table_name

		;;

	4) break  ;;

	*) echo " Invalid input "


	esac 
done



