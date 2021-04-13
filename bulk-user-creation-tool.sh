#!/bin/bash

function bulk_user_creation_tool() {
    
    #Program purpose message
    echo "Bulk user creation tool v1.0"
    echo "Author: I.D.(2014447)"
    
    #Leave an empty line
    echo ""

    #Checking if the log file is empty and if true add headers
    #If file usersCreated.log is not present it will be automatically created
    if [ ! -s usersCreated.log ] 
    then
        printf "Creation Date %-10sUsername\n" > usersCreated.log
    fi

    autoUserCreation
}

function autoUserCreation() {

    #Declaring an array that will hold the users
    declare -a userList

    #Get current date and time
    currentDate=$(date +%D-%T)

    #Fill the array with all the users from the text document
    mapfile -t userList < users.txt

    #Loop through the users array and create an user with that username
    for user in "${userList[@]}"
    do  
        #remove .pwd.lock file as it causing the useradd command to fail execution
        sudo rm /etc/.pwd.lock
        #create user with generic password from the username list
        sudo useradd -m -p $(openssl passwd -1 "pa55word") $user

        #Expire the user password straing away, this way the user will 
        #need to change it on first login
        sudo passwd --expire $user

        #sudo userdel --remove "${user}"

        #Store the usernames to the log file in a formatted manner
        printf "$currentDate UTC %-2s$user\n" >> usersCreated.log
        #remove the usernames for which a profile is created from the source file
        sed -i "/${user}/d" users.txt
    done
}

#executing the program
bulk_user_creation_tool

#newUsernamesCheck() function periodically checks the user list for new user names
#It can be used if the script is to be run manually if not added to `cron`
#function newUsernamesCheck() {
#    while true
#    do
#        clear
#        bulk_user_creation_tool
#        #It can be used to check the username in the system(used for debugging)
#        #compgen -u
#
#        #sleep for 10s before moving to the next line of the script
#        sleep 10
#    done
#}
#newUsernamesCheck
