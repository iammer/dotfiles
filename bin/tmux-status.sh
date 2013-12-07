#!/bin/bash

if [[ -d ~/code/min ]]; then
	echo $(cd ~/code/min; git branch | grep '*' | tr -d ' ') $(date +"%F %I:%M %p") [$(uptime | sed -e 's/.*average: //' -e ' s/,//g')]
else
	echo $(date +"%F %I:%M %p") [$(uptime | sed -e 's/.*average: //' -e 's/,//g')]
fi
