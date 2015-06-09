#!/bin/bash

# validate input
if [ $# -ne 2 ]
  then
    >&2 echo "usage: ./get_newest_file.sh <folder> <filename_match>"
    exit 1

fi

FILENAME=`ls $1 2> /dev/null | grep "$2" | sort | head -1` 

if [ -z "$FILENAME" ]; then
	>&2 echo "couldn't find $2 in $1"
	exit 2
else
	echo $FILENAME
	exit 0
fi
