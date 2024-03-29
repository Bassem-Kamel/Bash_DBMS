#!/bin/bash

table_name=$1
scriptpath=$2


# create two file one for colmuns name and data (table_name) , a hidden one for datatypes (.table_name.meta)
touch $table_name .$table_name.meta
#----------------------------------------------------
# get number of cols from user and check the value
numpat="[1-9]"
while true
do
	read -p "enter numbers of columns: " col

	if [[ $col = $numpat ]]
	then
		break
	else
		error "Error: it must be a number greater than 0"
	fi
done


# take name of every column and its datatype , check name for every column and check the value of datatype
# ncol : array contain the columns names 
# typ : array contain all datatypes of the table
for ((a=0 ; a<col ; a++ ))
do 
	if [ $a -eq 0 ]
	then 
		highlight "Note: this column will be the primary key"
	fi

	read -p "enter the name of col $a : " ncols[$a]
	. $scriptpath/name_validation.sh ${ncols[$a]}
	ncols[$a]=$name

	while true
	do
		read -p "enter the type of col $a: [i/s]: " typ[$a]
		if [ "${typ[$a]}" = "i" -o "${typ[$a]}" = "s" ]
		then
			hline "%14s"
			break
		else
			error "Error: not a valid value, try again"
		fi
	done



done
#-------------------------------------------------------------------

# create the first record which contain the columns name and the datatypes 
frecord="${ncols[0]}"
typs="${typ[0]}"

for ((i=1 ; i<col ; i++))
do 
	frecord="$frecord"":""${ncols[$i]}"
	typs="$typs"":""${typ[$i]}"

done

success "the record = $frecord and the types = $typs"

echo "$frecord" > $table_name
echo "$typs" > .$table_name.meta

