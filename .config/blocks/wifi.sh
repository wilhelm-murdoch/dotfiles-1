#!/bin/bash
name=`iwconfig wlp3s0 | grep ESSID | awk '{print $4}' | sed 's/.*\://' | tr -d '"'`
if [ $name == "off/any" ]
then
	echo " OFF"
else
	echo "" $name
fi
