#!/bin/bash

#Program purpose message
echo "File Size Email Monitor v1.0"
echo "Author: I.D.(2014447)"

#Get current date and time
currentDate=$(date +%D-%T)

#Assigning the alert trigger value to var
#If no arg passed trigger default=50%
if [ ! $1 ]
then
    usageAllertTrigger=50
else
    usageAllertTrigger=$1
fi

#Getting the total usage percentage and saving it againt variable
#And converted the string to numeric value
totalUsage=$(df -h --total | tail -n 1 | awk '{ print ($5+0) }')

#email alert structure
subject="System space usage alert"
body="System space usage at $totalUsage % \nAllert triggered at: $usageAllertTrigger %\nDate: $currentDate UTC"
from="file-size-monitor@alert.com"
#add more recepients sepparated by comma
to="iliqn1994@gmail.com"

if [[ "$totalUsage" -ge "$usageAllertTrigger" ]]
then
    #send the email alert out
    echo -e "Subject:${subject}\n${body}" | sendmail -f "${from}" -t "${to}"
    echo "Alert sent: $currentDate UTC"
fi
