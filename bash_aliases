alias tm='tmux attach || tmux new'
alias tmMarkPane='echo $TMUX_PANE > ~/.markedPane'
alias tmJoinPane='tmux join-pane -s `cat ~/.markedPane`'
alias tmQuad='tmux split-window \; split-window -h \; select-pane -U \; split-window -h'
alias tmTri='tmux split-window  -h -p 33 \; split-window \; select-pane -L'
alias tmSwap1='tmux display-message -p "#{pane_id}" > ~/.swapPane'
alias tmSwap2='tmux bind-key v swap-pane -d -s `tmux display-message -p "#{pane_id}"` -t `cat ~/.swapPane`'

[[ -f /sbin/md5 ]] && alias md5sum='md5 -r'
# vim:ft=sh
