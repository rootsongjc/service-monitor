#!/bin/bash
###I##################
#Author: jcsong
#Date: 2014-09-10
#####################
#Log file path.
logfile=../log/monitor-alert.log
echo "[INFO] $(date "+%Y-%m-%d %H:%M:%S") Meteor monitor start running." >> $logfile
function getconf(){
	item=$1
	value=`sed -n "s/.*$item *= *\([^ ]*.*\)/\1/p" ../conf/conf.ini|sed 's/ //g'|tr -d "\r"`
	echo $value
	return 1
}

phones=$(getconf phones)
services=$(getconf services)
interval=$(getconf interval)

＃Start monitor the service and send SMS text message the phones if the service down.
function start_monitor(){
srv=$1
time=$(date "+%Y-%m-%d %H:%M:%S")
# Check srv process status.
process=`jps|cut -d " " -f2|grep $srv`
upLine=`grep -c "$srv is up" $logfile|cut -d ":" -f1|tail -n1`
downLine=`grep -c "$srv is down" $logfile|cut -d ":" -f1|tail -n1`

#if process dead
if test "$process" != "$srv"  ; then
	echo "[ERROR] $time $srv is down." >> $logfile
	python alarm.py message -b "[ERROR] $time Host:`hostname -i` $srv is down." -s "$srv" -a "5279aa31" -p "$phones" -u "DOWN" -i `hostname -i`
	echo "[INFO] $time Send $srv down signal." >> $logfile
	#process live, but recovered from dead just now.
elif [ $upLine -lt $downLine ] || [ $upLine -eq $downLine ] ; then
	echo "[INFO] $time $srv is up." >> $logfile
	python alarm.py message -b "[INFO] $time Host: `hostname -i` $srv is up." -s "$srv" -a "5279aa31" -p "$phones" -u "OK" -i `hostname -i`
	echo "[INFO] $time Send $srv up signal." >> $logfile
fi
}

#Translate string to array.
OLD_IFS="$IFS" 
IFS="," 
arr=($services) 
IFS=$OLD_IFS
while true
do
	for srv in ${arr[@]}
	do
		start_monitor $srv
	done
	sleep $interval
done
