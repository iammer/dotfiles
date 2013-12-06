#!/bin/bash

if [[ -d ~/code/min ]]; then
	echo $(cd ~/code/min; git branch | grep '*' | tr -d ' ') $(date +"%F %I:%M %p") [$(uptime | cut -d : -f 4 | tr -d ',' | cut -c 2-)]
else
	echo $(date +"%F %I:%M %p") [$(uptime | cut -d : -f 4 | tr -d ',' | cut -c 2-)]
fi
