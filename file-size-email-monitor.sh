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