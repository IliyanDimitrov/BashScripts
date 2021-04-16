#!/bin/bash

#Information about the app
echo "CLI User Management Tool v1.0"
echo "Author: I.D.(2014447)"

#Menu
function menu() {
    
    #Menu options
    echo "1. Add new user"
    echo "2. Remove current user"
    echo "3. Change current user password"
    echo "4. Add/Remove privilege"
    echo "5. Quit"

    #Save the user choice
    read -p "Please enter your choice: " choice

    #Ask for username only if the user choose options 1-4
    if [[ choice -ne 5 ]]; then
        askForUsername
    fi

    #Based on the user choice execute the appropriate function
    if [ $choice == 1 ]; then
        createUser
        echo ""
        menu
    elif [ $choice == 2 ]; then
        deleteUser
        echo ""
        menu
    elif [ $choice == 3 ]; then
        changePassword
        echo ""
        menu
    elif [ $choice == 4 ]; then
        editPriviledges
        echo ""
        menu
    else
        echo $'Invalid choice. Try again.\n'
        menu
    fi
}

#Simply take the username input
function askForUsername() {
    read -p "Please enter a username: " username
}

#Create new user
function createUser() {
   
    if [[ $(grep -c "^$username:" /etc/passwd) -ne 0 ]]; then
        echo $'User already exist. Try Again.\n'
        askForUsername
    else
        useradd -m $username
        echo "Created user: $username with home dir: ~$username" 
    fi
}

#Delete existing user
function deleteUser() {

    if [[ $(grep -c "^$username:" /etc/passwd) -ne 0 ]]; then

        deluser --remove-home $username
        echo "User Deleted: $username with home dir: ~$username"
    else
        echo $'User not found. Try again.\n'
        askForUsername
    fi
}

#Change existing user password
function changePassword() {

    if [[ $(grep -c "^$username:" /etc/passwd) -ne 0 ]]; then

        read -p "Enter password: " PASSWORD     
        echo -e "$PASSWORD\n$PASSWORD" | passwd $user
        passwd -e ${username}
    else
        echo $'User not found. Try again.\n'
        askForUsername
    fi
}

#Edit existing user sudo priviledges
function editPriviledges() {

    if [[ $(grep -c "^$username:" /etc/passwd) -ne 0 ]]; then

        read -p "Please confirm sudo priviledge[y/n]" confirm

        if [ "$confirm" = "y" ]; then
            sudo usermod -aG sudo $username
            echo "Sudo permission given to: $username with home dir: ~$username"
        fi
    else
        echo $'User not found. Try again.\n'
        askForUsername
    fi

}


#Ask the user to type a username
#Check if the username already exist

#Execute the program
while [[ choice -lt 5 ]]
do
    menu
done