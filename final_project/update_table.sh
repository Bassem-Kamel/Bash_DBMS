#!/bin/bash

shopt -s extglob

table_name=$1

# ---------------- get the pk and check if the value is valid ----------------------------
while true
do

	read -p "enter the PK : " pk

	case $pk in

		+([0-9]) ) 
			findpk=$(cut -f1 -d: $table_name|grep $pk)
			if [ $findpk ]
			then
				info "$pk exists"
				R=$(awk -F: -v p="$pk" '{if ($1==p) print$0}'  $table_name)
				info "the record : $R "
				break
			else
				error "Error: $pk doesn't exist"
			fi
				;;
		*) error "invaild PK, it must be a number"
			;;
	esac
done


col=$(head -1 .$table_name.meta | tr ':' ' ' | wc -w)

#------------------------------ get the field and check if the value is valid ---------------------------
while true
do

	read -p "enter field number : " field

	case $field in
		+([0-9]) )
		if [ $field -le $col -a $field -gt 0 ]
		then 
		info " valid field"
		break
		else
		error "invalid field, it must be between 1 and $col"
		fi
			;;
		*) 
		error "field must be a number"
		;;
	esac

done

col_typ=$(head -1 .$table_name.meta | cut -f$field -d:)

old=$(echo $R | cut -f$field -d:)

# --------------------------------- get the new value and check if it's valid ------------------
while true
do
	read -p "enter the new value : " new
	
		if [ $col_typ = 'i' ]
                then
                        case $new in
                        +([0-9]) ) info "valid value"
				R=$(echo $R | sed "s/$old/$new/")
				break
                                ;;
                        *) error "Error: invalid value, try again"
                                ;;
                        esac
                elif [ "$col_typ" = 's' ]
                then
                        case $new in
                        +([a-zA-Z0-9_@' '.]) ) success "valid value, the data is updated"
				R=$(echo $R | sed "s/$old/$new/")
				break
                                ;;
                        *) error "Error: invalid value, try again "
                                ;;
                        esac
                fi

done
#------------------------------------------------ delete old line and append the new one -----------------------
sed -i "/$pk/d" $table_name
echo $R >> $table_name
sort -n -k1 -t: -o $table_name $table_name
#cat $table_name









