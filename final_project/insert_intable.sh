#!/bin/bash

table_name=$1
record=''
shopt -s extglob


col=$(head -1 $table_name | tr ':' ' ' | wc -w)
echo $col

for ((f=1; f < $col+1 ; f++ ))
do

	col_name=$(head -1 $table_name | cut -f$f -d:)
	col_typ=$(head -1 .$table_name.meta | cut -f$f -d:)

	if [ $f -eq 1 ]
	then 
		echo " --- note the first col is the primary key "
	fi

	while true 
	do

		read -p "--- enter the value of col ($col_name) and type ($col_typ) : " value

		if [ $f -eq 1 ]
		then 
			found=$(cut -f1 -d: $table_name | grep "$value")
			if [ $found ]
			then 
				echo " Error : Primary key must be unique , enter another value"
				continue
			fi

		fi



		if [ $col_typ = 'i' ]
		then 
			case $value in 
			+([0-9]) ) echo " ----- valid value ---- "
				record=$record':'$value
				break
				;;
			*) echo " error invalid value, try again "
				;;
			esac
		elif [ "$col_typ" = 's' ]
		then 
			case $value in 
			+([a-zA-Z]) ) echo "------ valid value -----"
				record=$record':'$value
				break
				;;
			*) echo "error invalid value , try again "
				;;
			esac
		fi
	done
	echo $value
done
record=$(echo $record | sed 's/://') #remove first : 
echo $record >> $table_name


