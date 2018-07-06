#!/bin/bash

echo $(date -u "+%F %H:%M") [$(uptime | sed -e 's/.*averages*: //' -e 's/,//g')]
