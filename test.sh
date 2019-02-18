#!/bin/sh
PIDFILE=/home/kambaa/Desktop/myProxyServer.pid

if [ -f $PIDFILE ]
then
  # do something
  PID=$(cat $PIDFILE)
  echo "PIDFILE Exists, process id is: $PID"
  rm $PIDFILE
  kill -9 $PID
else
  echo $$ > $PIDFILE
  if [ $? -ne 0 ]
  then
    echo "Could not create PID file"
    exit 1
  fi
fi
