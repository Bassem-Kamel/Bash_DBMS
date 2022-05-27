#!/bin/bash

shopt -s extglob
table_name=$1

PS3="--> enter your choice : "


# ----------------------------------- get primary key function -------------
function get_pk {

while true
do

                read -p "enter the PK: " pk
                findpk=$(cut -f1 -d: $table_name|grep -w "$pk")

                case $pk in

                        +([0-9]) )
                        if [ $findpk ]
                        then
                                info "$pk exists "
                                R=$(awk -F: -v p="$pk" '{if ($1==p) print$0}'  $table_name)
                                info "the record : $R"
                                break
                        else
                                error "Error: $pk doesn't exist"
                        fi
                                ;;
                *) error "invaild PK, it must be a number"
                        ;;
                esac
 done


}




# -------------------------- menu to choose the action ------------------

select D in "Delete All" "Delete a record" "Delete a value" "Back to Menu"
do
	case $REPLY in 
		1) echo "deleting all values in the table"
		sed -i '2,$d' $table_name
		success "the data is now deleted"
		;;
		2) 
		echo "delete a record"

		get_pk


		sed -i "/\b$pk\b/d" $table_name
		success "record deleted successfully"
		;;

		3) 
		echo "delete a value"

		get_pk

		col=$(head -1 $table_name | tr ':' ' ' | wc -w)
		while true
		do

        		read -p "enter field number : " field
        	case $field in
        	        +([0-9]) )
                	if [ $field -le $col -a $field -gt 1 ]
               		then
                	success "valid field"
               	 	break
                	else
                	error "invalid field"
                	fi
                        ;;
                	*)
                	error "field must be a number"
                	;;
        	esac

		done
		old=$(echo $R | cut -f$field -d:)
		R=$(echo $R | sed "s/$old/' '/")
		sed -i "/\b$pk\b/d" $table_name
		echo $R >> $table_name
		sort -n -k1 -t: -o $table_name $table_name
		success "value deleted"

		;;

	4) break  ;;

	*) error " Invalid input "


	esac 
done



