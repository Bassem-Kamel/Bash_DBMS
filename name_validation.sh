#!/bin/bash


read -p "enter the name : " name
pat="[^0-9a-zA-Z]"
name_status="empty"
charpat="[^a-zA-Z]"


if [[ ${name:0:1} = $charpat ]]
then 
	echo " first letter must be char not number or specialchar"
	valid1=false
else
	valid1=true
fi




for ((i=0; i<${#name}; i++ ))
do

	c="${name:$i:1}"
	echo "$c"


	if [[ $c = $pat ]]
	then
	       name_status=false	
		echo "it is a special char"
		break
	else
		name_status=true
		echo "it is a valid char"
	fi
done


echo " $valid1 and $name_status "

if [ "$valid1" = true -a "$name_status" = true ]
then
	echo "final status = valid operation "
else
	echo "final status = invalid operation"
fi












