#!/bin/sh
PIDFILE=/home/kambaa/Desktop/myProxyServer.pid
activeStatus="{\"status\":1}"
passiveStatus="{\"status\":0}"

currStatus=$(curl -sS --insecure '<MY_URL>')
if [ $currStatus = $activeStatus ]
then
	if [ -f $PIDFILE ]
	then
		echo "PIDFILE exists,skipping."
	else
		#activate if not exists
		echo $$ > $PIDFILE
		if [ $? -ne 0 ]
		then
		echo "Could not create PID file"
		exit 1
		fi
	  	sshpass -p '<MY_PASSWORD>' ssh -D <MY_PORT> -q -C -N -p <MY_SSH_PORT> <MY_USERNAME>@><MY_SERVER_ADDRESS>
	fi
fi

if [ $currStatus = $passiveStatus ]
then
	if [ -f $PIDFILE ]
	then
	  PID=$(cat $PIDFILE)
	  rm $PIDFILE
	  kill -9 $PID
	fi
fi
