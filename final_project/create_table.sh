#!/bin/bash

table_name=$1


touch $table_name .$table_name.meta
#----------------------------------------------------

numpat="[1-9]"
while true
do
	read -p "enter numbers of columns =" col

	if [[ $col = $numpat ]]
	then
		break
	else
		echo "-Error : it must be a number greater than 0"
	fi
done



for ((a=0 ; a<col ; a++ ))
do 
	if [ $a -eq 0 ]
	then 
		echo "!(Note): this col will be the primary key "
	fi

	read -p "enter the name of col $a : " ncols[$a]
	. name_validation.sh ${ncols[$a]}
	ncols[$a]=$name

	while true
	do
		read -p "enter the type of col $a  [i/s] :" typ[$a]
		if [ "${typ[$a]}" = "i" -o "${typ[$a]}" = "s" ]
		then
			break
		else
			echo "-Error : not valid value , try again"
		fi
	done



done
#-------------------------------------------------------------------


frecord="${ncols[0]}"
typs="${typ[0]}"

for ((i=1 ; i<col ; i++))
do 
	frecord="$frecord"":""${ncols[$i]}"
	typs="$typs"":""${typ[$i]}"

done

echo "the record = $frecord and the types = $typs"

echo "$frecord" > $table_name
echo "$typs" > .$table_name.meta

