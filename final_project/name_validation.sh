#!/bin/bash
 
	name=$1
	pat="[^0-9a-zA-Z_]"
	name_status="empty"
	charpat="[^a-zA-Z_]"

while true
do
	#check if the first letter is char or not ---------------------
	if [[ ${name:0:1} = $charpat ]]
	then 
	error "Error: first letter must be a character not a number or a special character"
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
		error "Error: the name can't contain special character"
	    name_status=false	
		break
		else
		name_status=true
		fi
	done


	# if the first letter is char and there is no special char , so the name is valid -------------------
	if [ "$valid1" = true -a "$name_status" = true ]
	then
		info "The name is a valid name"
		break
	else
		error "invalid name, try again"
		read -p "(name validation) enter a new name: " name
	fi


done











