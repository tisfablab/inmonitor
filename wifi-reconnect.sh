#!/bin/bash

INTERFACE="wlan0"

if ! ifconfig $INTERFACE | grep -q "inet addr:"; then
	echo "Script aborted: Network on $INTERFACE was down on startup."
	exit 1
fi

while true ; do
   if ifconfig $INTERFACE | grep -q "inet addr:" ; then
      echo "Network is up. Not doing anything."
   else
      echo "Network connection down! Attempting reconnection."
      ifup --force $INTERFACE
   fi
   sleep 300
done

