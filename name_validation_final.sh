#!/bin/bash



while true 
do

	read -p "==> enter the name : " name
	echo " ----------------------"
	pat="[^0-9a-zA-Z_]"
	name_status="empty"
	charpat="[^a-zA-Z_]"


	if [[ ${name:0:1} = $charpat ]]
	then 
	echo "-Error:first letter must be char not number or special char"
	valid1=false
	else
	valid1=true
	fi




	for ((i=0; i<${#name}; i++ ))
	do

		c="${name:$i:1}"


		if [[ $c = $pat ]]
		then
		echo "-Error: the name can't contain special char"
	        name_status=false	
		break
		else
		name_status=true
		fi
	done


	echo "-----------------------------------"

	if [ "$valid1" = true -a "$name_status" = true ]
	then
	echo "final status = valid operation "
	export name
	break
	else
	echo "final status = invalid operation , try again"
	fi




done










