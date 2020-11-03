#!/bin/bash
clear
echo "--------------- User Deletion Script --------------------"
echo "*******************************************************************"


#while [ 1 ]
#do
echo "please enter user name : "
read -e ch
#clear


#Delete From ipa
echo -n  'Ph@rm@$0ftP@ssw0rd777' | kinit admin  > /dev/null
ipa user-find $ch > /dev/null


if [ $? -eq 0 ]
then
        echo " "
        echo "User was found"
        echo "User's data:"
        ipa user-find $ch
else
        echo " "
        echo "This user doesn't exist. Please check the username "
        exit 1
fi
#done
