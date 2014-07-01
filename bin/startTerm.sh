#!/bin/bash
[[ -x /usr/local/bin/bash ]] && SHELL=/usr/local/bin/bash

/usr/local/bin/tmux attach || /usr/local/bin/tmux new $SHELL
