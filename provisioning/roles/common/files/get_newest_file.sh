#!/bin/bash
source {{ scripts_dir }}/functions.sh

# validate input
if [ $# -ne 2 ]
  then
    >&2 echo "usage: ./get_newest_file.sh <folder> <filename_match>"
    exit 1

fi

get_newest_file $1 $2