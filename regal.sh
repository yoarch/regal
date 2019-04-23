#!/bin/bash

function check_args {

	if [ "$#" -eq 1 ] && ([[ $1 == "-h" ]] || [[ $1 == "--help" ]]); then
		cat /usr/lib/regal/README.md
		exit 0
	fi

	if [ -z $2 ]; then
		echo -e "\n\t${BWHITE}needs at least two arguments being the time in timemode you want the regular alarm to remind you every each period\n\tfor 2 minutes enter:\n\tregal 2 m"
		exit 1
	fi

	if ! [[ "$1" =~ ^[0-9]+$ ]]; then
		echo -e "\n\t${BWHITE}first argument must be an integer being the time in timemode you want the regular alarm to remind you every each period\n\tfor 2 minutes enter:\n\tregal 2 m"
		exit 1
	fi

	if [[ "$2" != 'h' ]] && [[ "$2" != 'm' ]] && [[ "$2" != 's' ]]; then
		echo -e "\n\t${BWHITE}second argument must be \"h\" or \"m\" or \"s\":\n\tregal 2 m"
		exit 1
	fi
}

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
	printf "\n$i: "
	for (( d=1; d<=$i; d++ )) do
		printf "."
	done
	sleep $x_seconds
	mpv $audiopath > /dev/null 2>&1 &
	i=$((i+1))
}

BWHITE='\033[1m' # bold white
NC='\033[0m' # no color

check_args "$@"

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

echo -e "\n\tend of the repetitions ...${NC}\n"
