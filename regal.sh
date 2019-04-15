#!/bin/bash

if [ -z $2 ]; then
	echo -e "\n\tneeds at least 2 args being the time and the mode\n\nfor 30 seconds enter:\nregal 30 s\n\nfor 10 minutes enter:\nregal 10 m"
	return 1
fi

function args_to_scds {
	x_seconds=0
	if [[ $2 == "h" ]]; then
		x_seconds=$(($1*3600))
	elif [[ $2 == "m" ]]; then
		x_seconds=$(($1*60))
	elif [[ $2 == "s" ]]; then
		x_seconds=$1
	else
		echo -e "$2 arg is not supported, please enter \"h\", \"m\" or \"s\""
		return 1
	fi
}

function regal {
	echo -e "$i:\t..."
	sleep $x_seconds
	mpv $audiopath > /dev/null 2>&1 &
	i=$((i+1))
}

BWHITE='\033[1m' # bold white
NC='\033[0m' # no color

every=$1
# timemode can be "h": hours, "m": minutes, "s": seconds
timemode=$2
howmanytime=${3:-inf}
audiopath=${4:-"/usr/share/sounds/regal/duck.wav"}

args_to_scds $every $timemode

echo -e "\n\t${BWHITE}starting regal ($(date +"%T"))\n\n\tducking every $every$timemode ...\n\n"
i=1
if [[ $howmanytime == "inf" ]]; then
	while true
	do
		regal
	done
else
	for (( time=1; time<=$howmanytime; time++ )) do
		regal
	done
fi

echo -e "\n\tend of the repetitions ...\n"
