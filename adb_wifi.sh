#!/bin/bash

port="5555"
# disconnect existing adb connections first
adb disconnect
devices=`adb devices|grep -w device`

if [ -n "$devices" ]; then
    # get the phone ip
    ip=`adb shell ifconfig wlan0 | grep -w inet | awk '{print $2}' | awk -F ':' '{print $2}'`

    if [ -z "$ip" ]; then
        echo "Use the second method to get the ip"
        ip=`adb shell ip addr show | grep wlan0 | grep -w inet | awk -F '/' '{print $1}' | awk -F ' ' '{print $2}'`
    fi

    if [ -n "$ip" ]; then
        result=`adb tcpip ${port}`
        result=`adb connect ${ip}`
        echo $result
    else
        echo "Please check that your phone and computer are connected to the same network"
    fi
else
    echo "Please check if the phone is connected to the computer via USB"
fi
