#!/bin/bash
clear
echo "--------------- User Deletion Script --------------------"
echo "*******************************************************************"

#while [ 1 ]
#do
echo "please enter user name : "
read -e name
#clear


#Delete From ipa
echo 'VXNlckFkbSFuQFBoQHJtQDU1NQo=' | openssl enc -base64 -d | kinit useradmin  > /dev/null
ipa user-find $name > /dev/null


if [ $? -eq 0 ]
then
        echo " "
	echo "User was found"
	echo "User's data:"
	ipa user-find $name
	while [ 1 ]
	do
 
		echo "do you want to delete $name ? (Y or N)"
		read -e ch
		if [ $ch = "Y" ] || [ $ch = "y" ]
		then
			
			mv /home/vmail/$name  /home/discarded
			ipa user-del $name
			echo "user: "$name " was deleted by: " `whoami` "at time: " `date` >> /scripts/deletion-script-log
			
			exit
		elif [ $ch = "N" ] || [ $ch = "n" ]
		then
			exit 
		else
			echo "Wrong Choice, please try again !"
	
		
		fi
	done		
	
else
	echo " "
	echo "This user doesn't exist. Please check the username "
	ls /home/vmail/* |grep $name > /dev/null
	if [ $? -eq 0 ]
	then
		echo "This user is removed from freeipa and will be discarded"
		mv  /home/vmail/$name  /home/discarded

	fi
	exit 1
fi
