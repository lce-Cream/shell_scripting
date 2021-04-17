#!/bin/sh
help(){
echo "Usage: dict [word] [options...]
Displays a couple of definitions for a given word in english divided by # sign.

 --help 	Get help message"
}

if [[ $1 == "--help" ]]; then
	help
	exit
fi

URL_START="https://www.dictionaryapi.com/api/v3/references/learners/json/"
URL_END="?key=2a971670-b122-49a2-b2df-487e11594e0e"
WORD=$1
URL="$URL_START$WORD$URL_END"

curl -s $URL | python -c \
"import sys, json
try:
	for definition in json.load(sys.stdin)[0]['shortdef']:
		print('#', definition)
except Exception as ex:
	print(ex)
"