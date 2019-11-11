#!/bin/bash

port="5555"
# disconnect existing adb connections first
adb disconnect
devices=`adb devices|grep -w device`
device_count=${#devices}

if [ $device_count != 0 ]; then
    # get the phone ip
    ip=`adb shell ifconfig wlan0|grep -w inet|awk '{print $2}'|awk -F ':' '{print $2}'`
    ip_len=${#ip}

    if [ $ip_len != 0 ]; then
        result=`adb tcpip ${port}`
        result=`adb connect ${ip}`
        echo $result
    else
        echo "Please check that your phone and computer are connected to the same network"
    fi
else
    echo "Please check if the phone is connected to the computer via USB"
fi
