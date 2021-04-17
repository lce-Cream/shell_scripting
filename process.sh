#!/bin/sh
help(){
echo "Usage: process [options...]
Displays information about first 10 processes and kills the process with specified PID.

 -k, --kill  PID 	terminates the process with corresponding PID
 -h, --help 		show brief description of the command"
}

if [[ $1 == "" ]]; then
	echo "Image Name                     PID Session Name        Session#    Mem Usage"
	echo ========================= ======== ================ ===========  ============
	tasklist -nh -fi "session eq 1" | sort -k 5 -r | head
	exit

elif [[ $1 == "--help" || $1 == "-h" ]]; then
	help
	exit

elif [[ $1 == "--kill" || $1 == "-k" ]]; then
	kill $2
	exit

else echo Invalid argument $1
	 echo Try \'process --help\' for more information.
fi

