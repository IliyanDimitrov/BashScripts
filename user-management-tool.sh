#!/bin/bash


#Information about the app
echo "CLI User Management Tool v1.0"
echo "Author: I.D.(2014447)"

#Menu
function menu() {
echo "1. Add new user"
echo "2. Remove current user"
echo "3. Change current user password"
echo "4. Add/Remove privilege"

#Save the user choice
read -p "Please enter your choice: " choice
}

function askForUsername() {
    read -p "Please enter a username: " username
}

function createUser() {
   
    if [ id -u $username >/dev/null 2>&1 ]; then
        echo "User already exist. Try Again."
        username=""
        askForUsername
    else
        useradd -m $username
        eval echo "Created user: $username with home dir: ~$username" 
    fi
}

function deleteUser() {

    if [ id -u $username >/dev/null 2>&1 ]; then
        echo "User already exist. Try Again."
        username=""
        askForUsername
    else
        deluser -fr $username
        eval echo "User Deleted: $username with home dir: ~$username"
    fi
}

function changePassword() {

    if [ id -u $username >/dev/null 2>&1 ]; then
        read -s -p "Enter password: " password     
        echo $password | passwd --stdin $user
    else
        echo "User not found. Try Again."
        askForUsername
    fi
    

}

function editPriviledges() {
    read -p "Please confirm [y/n]" confirm
    if [ "$confirm" = "y" ]; then
    useradd -m $username
    eval echo "Created user: $username with home dir: ~$username"
    fi
}


#Ask the user to type a username
#Check if the username already exist

#Execute the program
menu

