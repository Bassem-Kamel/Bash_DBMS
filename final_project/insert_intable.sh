#!/bin/bash

# create empty record to save data in it
table_name=$1
record=''
shopt -s extglob

col=$(head -1 $table_name | tr ':' ' ' | wc -w)
info "number of columns is $col"

# loop over every column and print its name and datatype
for ((f=1; f < $col+1 ; f++ ))
do

	col_name=$(head -1 $table_name | cut -f$f -d:)
	col_typ=$(head -1 .$table_name.meta | cut -f$f -d:)

	if [ $f -eq 1 ]
	then 
		highlight "Note: the first column is the primary key"
	fi

	# after get the values from the user , check them if valid save them in the table
	while true 
	do

		read -p "enter the value of col ($col_name) that has the type ($col_typ): " value

		if [ $f -eq 1 ]
		then 
			found=$(cut -f1 -d: $table_name | grep -w "$value")
			if [ $found ]
			then 
				error "Error: primary key must be unique, try another value"
				continue
			fi

		fi

		if [ $col_typ = 'i' ]
		then 
			case $value in 
			+([0-9]) ) info "valid value"
				record=$record':'$value
				break
				;;
			*) error "Error: invalid value, try again "
				;;
			esac
		elif [ "$col_typ" = 's' ]
		then 
			case $value in 
			+([a-zA-Z0-9_@' '.]) ) info "valid value"
				record=$record':'$value
				break
				;;
			*) error "Error: invalid value, try again "
				;;
			esac
		fi
	done
done
record=$(echo $record | sed 's/://') #remove first redandant colon : 
echo $record >> $table_name # save the record in the table


