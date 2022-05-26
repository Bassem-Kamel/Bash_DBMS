#!/bin/bash

shopt -s extglob

table_name=$1

# ---------------- get the pk and check if the value is valid ----------------------------
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


col=$(head -1 .$table_name.meta | tr ':' ' ' | wc -w)

#------------------------------ get the field and check if the value is valid ---------------------------
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

col_typ=$(head -1 .$table_name.meta | cut -f$field -d:)

old=$(echo $R | cut -f$field -d:)

# --------------------------------- get the new value and check if it's valid ------------------
while true
do
	read -p "enter the new value : " new
	
		if [ $col_typ = 'i' ]
                then
                        case $new in
                        +([0-9]) ) echo " ----- valid value ---- "
				R=$(echo $R | sed "s/$old/$new/")
				break
                                ;;
                        *) echo " error invalid value, try again "
                                ;;
                        esac
                elif [ "$col_typ" = 's' ]
                then
                        case $new in
                        +([a-zA-Z]) ) echo "------ valid value -----"
				R=$(echo $R | sed "s/$old/$new/")
				break
                                ;;
                        *) echo "error invalid value , try again "
                                ;;
                        esac
                fi

done
#------------------------------------------------ delete old line and append the new one -----------------------
sed -i "/$pk/d" $table_name
echo $R >> $table_name
sort -n -k1 -t: -o $table_name $table_name
cat $table_name









