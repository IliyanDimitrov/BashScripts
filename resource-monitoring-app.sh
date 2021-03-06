#!/bin/bash

function monitorResources() {
    
    #Program purpose message
    echo "System resources monitoring application v1.0"
    echo "Author: I.D.(2014447)"
    
    #Leave an empty line
    echo ""

    #Hostname
    local hostname=$(hostname)
    echo "Hostname: $hostname"

    #Kernel version
    local kernelVersion=$(uname -srm)
    echo "Kernel Version: $kernelVersion"

    #Number of tasks running
    local countActiveTasks=$(ps -au | wc -l)
            
    #As wc is counting all lines I want to remove the header and the last new line from the count
    local numberOfTasks=$((countActiveTasks - 2))
    echo "Number of tasks running: $numberOfTasks"

    #System up-time
    local uptime=$(uptime --pretty)
    echo "System up-time: $uptime"

    #Total and available RAM
    local totalRam=$(free -m | grep Mem | awk '{print "Total RAM size: " $2 "Mb"}')
    local availableRam=$(free -m | grep Mem | awk '{print "Total RAM available: " $4 "Mb"}')
 
    echo "RAM usage statistics:"
    echo $totalRam
    echo $availableRam


    #Total CPU usage
    local cpuUsage=$(ps -A -o pcpu | tail -n+2 | paste -sd+ | bc)
    echo "CPU usage: $cpuUsage %"

    #Total and available disk size
    local totalStorageSize=$(df --total -h | tail -n 1 | awk '{print "Total disk storage size: " $2}')
    local availableStorageSize=$(df --total -h | tail -n 1 | awk '{print "Available disk storage size: " $4}')
 
    echo "Disk size usage statistics:"
    echo $totalStorageSize
    echo $availableStorageSize


    #Process details including:
    #PID
    #User 
    #%CPU
    #%RAM
    #process command
    echo "Process details:"
    ps -au | awk '{ printf("%-10s%-10s%-10s%-10s%-10s\n",$2, $1, $3, $4, $11) }' 
    
}

#infinite loop to refresh the app every second
function refreshData() {
    while true
    do
        clear
        monitorResources
        sleep 1
    done
}

refreshData