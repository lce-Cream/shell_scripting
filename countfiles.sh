#!/bin/sh
help(){
echo '''Counts files with specified extensions

countfiles [source] [destination] [extensions]

ARGUMENTS
	[source]
		specifies directory for file counting
	[destination]
		specifies result output directory and file name
	[extensions]
		specifies file extensions to count
EXAMPLE
	countfiles c:/users/user1/desktop/other/ c:/users/user1/desktop/res.txt png txt pdf
	countfiles . ./result.txt pdf txt bat sh'''
}

count(){
for extension in "$@"
do
	echo "$(find $SOURCE -maxdepth 1 -type f | grep -o ".$extension\+$" | sort | uniq -c)" >> $DESTINATION
done
}

interactive(){
read -p "Source: " 		SOURCE
read -p "Destination: " DESTINATION
read -p "Extensions: "  EXTENSIONS
count $EXTENSIONS
}

if [[ $1 == "" ]]; then
	interactive
	exit

elif [[ $1 == "--help" || $1 == "-h" ]]; then
	help
	exit
fi

SOURCE=$1
DESTINATION=$2
shift 2
count $@