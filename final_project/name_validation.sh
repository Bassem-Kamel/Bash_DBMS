#!/bin/bash

	name=$1
	echo "------- ---------- (name validation) ------------------"
	pat="[^0-9a-zA-Z_]"
	name_status="empty"
	charpat="[^a-zA-Z_]"

while true
do
	#check if the first letter is char or not ---------------------
	if [[ ${name:0:1} = $charpat ]]
	then 
	echo "===! (Error):first letter must be char not number or special char"
	valid1=false
	else
	valid1=true
	fi



	# Loop over every char and check if it is valid or not ------------------
	for ((i=0; i<${#name}; i++ ))
	do

		c="${name:$i:1}"


		if [[ $c = $pat ]]
		then
		echo "===! (Error): the name can't contain special char"
	        name_status=false	
		break
		else
		name_status=true
		fi
	done


	# if the first letter is char and there is no special char , so the name is valid -------------------
	if [ "$valid1" = true -a "$name_status" = true ]
	then
		echo "============== valid name =============== "
		export name
		break
	else
		echo "!== Sorry invalid name , try again"
		read -p "(name validation) enter a new name: " name
	fi


done











