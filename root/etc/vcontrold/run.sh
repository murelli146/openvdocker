#!/bin/bash
#/usr/local/edomi/main/vcontrol/vcontrold -x /usr/local/edomi/main/vcontrol/vcontrold.xml -d /dev/ttyUSB0 -l /usr/local/edomi/main/vcontrol/vcontrold.log -p 3002 >/dev/null 2>&1 & echo $!
vcontrold -x /etc/vcontrold/vcontrold.xml -d /dev/ttyUSB0 -l /tmp/vcontrold.log -p $PORTCLI
status=$?
if [ $status -ne 0 ];then
	echo "Failed to start vcontrold"
	exit 0
else
 echo "vcontrold gestartet"
fi
