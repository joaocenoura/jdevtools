#!/bin/bash
function print_header {
	if [ "$#" -eq 0 ]; then
		echo -e "--------------------------------------------------------------------------------"
	elif [ "$#" -eq 1 ]; then
		echo "--------------------------------------------------------------------------------"
		echo "    $1"
		echo "--------------------------------------------------------------------------------"
	fi
}

# backup prefix filename with date time format (YYYYMMDD-HHMMSS)
function get_backup_prefix {
	echo `date +%Y%m%d-%H%M%S`
}

# perform backup of a directory by creating a tarball
#	$1 - backup directory
#	$2 - backup filename prefix (obtained from function get_backup_prefix)
#	$3 - backup filename suffix
#	$4 - directory to backup
function backup_tar {
	tar -cf ${1}/${2}_${3} -C / ${4}
}

# find the most recent backup and extract it
#	$1 - backup directory
#	$2 - filename suffix (without the date)
function restore_tar {
	FILENAME=`ls $1 | grep "$2" | sort | head -1`
	if [ -z "$FILENAME" ]; then
		echo "skipping restore of $2 (backup file not found)"
	else
		echo "restoring $1/${FILENAME} ..."
		sudo tar -xvf $1/${FILENAME} -C /
		echo "restore complete!"
	fi
}

function get_newest_file {
	# validate input
	if [ $# -ne 2 ]
	  then
	    >&2 echo "expecting 2 arguments: <folder> <filename_match>"
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
}