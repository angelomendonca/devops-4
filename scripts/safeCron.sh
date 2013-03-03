#!/bin/bash

PIDFILE=/var/run/__NAME__.pid
COMMAND="echo change me;exit -1"

function write_pid () {
	echo $$ >$PIDFILE
}

TOWAIT=$[ ( $RANDOM % 10 )  + 2 ]

find /tmp/ -name '*xls' -type f -mtime +2 -delete
echo Waiting $TOWAIT
sleep $TOWAIT

if [ -f $PIDFILE ] 
	then
	echo "$PIDFILE exists" 
	OLDPID=`cat $PIDFILE`
	ps --pid $OLDPID >/dev/null
	RESULT=$?
	[ $RESULT -eq 0 ] && echo "Process $OLDPID active exit" && exit -1
	echo "Removing stale pid $OLDPID does not exist"
	rm $PIDFILE
fi

echo "Updating the __NAME__ pid"
write_pid

while `true`
do
	echo "Launching... __NAME__ "
	$COMMAND
done

