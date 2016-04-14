#!/bin/bash

logfile="/tmp$$.log"

## Jobs

#|	1 --> 2 ---/
#|		--> 3 ---/ 
#|	 	--> 4 --/ 
#|	 	-- delay 30mins ---> verify

parent_1="node parent_1.js -f >/dev/null && echo 'parent_1 finished' >> $logfile"
parent_2="node parent_2.js -f >/dev/null && echo 'parent_2 finished' >> $logfile"
parent_3="node parent_3.js -f >/dev/null && echo 'parent_3 finished' >> $logfile"
parent_4="node parent_4.js -f >/dev/null && echo 'parent_4 finished' >> $logfile"

## Validate load
verify="node verify_load.js -f >/dev/null"

## Run job dependency
eval $parent_1 & eval $parent_2 & eval $parent_3 & eval $parent_4

## Logging
while true; do
	lines=`wc -l $logfile | cut -f 1 -d ' '`;
	echo "$logfile : $lines"
	## The logfile contains 4 lines if all jobs finished
	if [ "$lines" -eq 4 ]; then
		eval $verify
		## Delete logfile & exit
		rm $logfile
		exit 0;
	fi
	# Only check if the jobs are finished once a minute
	sleep 60;
done


