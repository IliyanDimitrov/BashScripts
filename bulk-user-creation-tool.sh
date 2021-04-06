#!/bin/bash

function bulk_user_creation_tool() {
    
    #Program purpose message
    echo "Bulk user creation tool v1.0"
    echo "Author: I.D.(2014447)"
    
    #Leave an empty line
    echo ""

    #Checking if the log file is empty and if true add headers
    if [ ! -s usersCreated.log ] 
    then
        printf "Creation Date %-10sUsername\n" > usersCreated.log
    fi

    autoUserCreation
}

function autoUserCreation() {

    #Declaring an array that will hold the users
    declare -a userList

    #Fill the array with all the users from the text document
    mapfile -t userList < users.txt

    #Loop through the users array and create an user with that username
    for user in "${userList[@]}"
    do  
        #create user with generic password from the username list
        sudo useradd -p $(openssl passwd -1 "pa55word") $user

        #Expire the user password straing away, this way the user will required to change it on first login
        sudo passwd --expire $user
        #sudo userdel --remove $user
        #Store the usernames to the log file in a formatted manner
        printf "$(date +%D-%TUTC) %-3s$user\n" >> usersCreated.log
        #remove the usernames for which a profile is created from the source file
        sed -i "/${user}/d" users.txt
    done
}

function newUsernamesCheck() {
    while true
    do
        clear
        bulk_user_creation_tool
        compgen -u
        sleep 10
    done
}

newUsernamesCheck


#https://www.tutorialkart.com/bash-shell-scripting/