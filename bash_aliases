alias dg='grails -reloading -Djava.awt.headless=true -Ddeployment=spida/dev'
alias cg='grails -Djava.awt.headless=true -Ddeployment=spida/circleci'
alias ddg='grails -debug-forked -reloading -Djava.awt.headless=true -Ddeployment=spida/dev'
alias dcg='grails -debug-forked -reloading -Djava.awt.headless=true -Ddeployment=spida/circleci'

alias tm='tmux attach || tmux new'
alias tmMarkPane='echo $TMUX_PANE > ~/.markedPane'
alias tmJoinPane='tmux join-pane -s `cat ~/.markedPane`'
alias tmQuad='tmux split-window \; split-window -h \; select-pane -U \; split-window -h'

[[ -f /sbin/md5 ]] && alias md5sum='md5 -r'
