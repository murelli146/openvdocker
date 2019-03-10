#!/bin/bash
#/usr/local/edomi/main/vcontrol/vcontrold -x /usr/local/edomi/main/vcontrol/vcontrold.xml -d /dev/ttyUSB0 -l /usr/local/edomi/main/vcontrol/vcontrold.log -p 3002 >/dev/null 2>&1 & echo $!
vcontrold -x /etc/vcontrold/vcontrold.xml -d /dev/ttyUSB0 -l /etc/vcontrold/vcontrold.log -p $PORTCLI
status=$?
if [ $status -ne 0 ];then
	echo "Failed to start vcontrold"
#	exit 0
else
 pid=$(pidof vcontrold)
# pid=$?
 echo "vcontrold gestartet PID: $pid"
fi
# Prüfintervall ob PIDfile vorhanden sonst Container beenden
while sleep 5; do
#	pidof vcontrold
	pidnow=$(pidof vcontrold)
	if [ $pid -eq $pidnow ]; then
		echo "PID OK $pid = $pidnow"
	else
		echo "exit 0"
#		exit 0
	fi
done
