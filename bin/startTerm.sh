#!/bin/bash
[[ -x /usr/local/bin/bash ]] && SHELL=/usr/local/bin/bash
SESSION=${1:-default}

if /usr/local/bin/tmux has-session -t $SESSION > /dev/null; then
	/usr/local/bin/tmux attach-session -t $SESSION
else
	/usr/local/bin/tmux new-session -s $SESSION $SHELL 
fi
