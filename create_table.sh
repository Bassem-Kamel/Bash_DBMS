#!/bin/bash

table_name=$1

if [ -d ./Tables ]
then 
	cd ./Tables
else
	mkdir ./Tables
	cd Tables
fi

touch $table_name $table_name.meta
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
	read -p "enter the name of col $a : " arr[$a]
	. name_validation.sh ${arr[$a]}
	arr[$a]=$name

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

echo "arry = ${arr[@]}"

record="${arr[0]}"
typs="${typ[0]}"

for ((i=1 ; i<col ; i++))
do 
	record="$record"":""${arr[$i]}"
	typs="$typs"":""${typ[$i]}"

done

echo "the record = $record and the types = $typs"

echo "$record" > $table_name
echo "$typs" > $table_name.meta

