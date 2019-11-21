#!/bin/bash

while [[ true ]]; do
	#statements
	duration=$(zenity --entry --title "Get a move on ! `date`")
	if [[ $duration == "0" ]]; then
		echo "duration 0, exiting"
		exit 0
	fi
	sleep ${duration}
done