#!/bin/bash

echo $(date +"%F %I:%M %p") [$(uptime | sed -e 's/.*averages*: //' -e 's/,//g')]
