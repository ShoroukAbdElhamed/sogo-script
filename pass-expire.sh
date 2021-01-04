day_num=14
year=$(date +%Y)
mon=$(date +%m)
day=$(date +%d)

echo 'UGhAcm1AJDBmdFBAc3N3MHJkNzc3Cg==' | openssl enc -base64 -d | kinit admin  > /dev/null

for user in $(ipa user-find --all --raw | grep uid: | awk '{print $2}')
do
year_exp=$(ipa user-show $user --all | grep 'User password expiration'| awk '{print $4}'| cut -c 1-4 )
mon_exp=$(ipa user-show $user --all | grep 'User password expiration'| awk '{print $4}'| cut -c 5-6 )
day_exp=$(ipa user-show $user --all | grep 'User password expiration'| awk '{print $4}'| cut -c 7-8 )

if [ $(($year_exp-$year)) -eq 0 ]
then
        if [ $(($mon_exp-$mon)) -eq 0 ]
        then
                if [ $(($day_exp-$day)) -le $day_num ]
                then
                        printf "Dear $user, \n\nYou have $(($day_exp-$day)) days left till your password expires. Kindly consider changing it soon. \n\n\nMail Admin" | mailx -s "Password Expiry Warning" -r $user so1
                fi
        fi
fi

done

