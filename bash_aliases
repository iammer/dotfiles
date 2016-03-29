#Tmux aliases
alias tm='tmux attach || tmux new'
alias tmMarkPane='echo $TMUX_PANE > ~/.markedPane'
alias tmJoinPane='tmux join-pane -s `cat ~/.markedPane`'
alias tmQuad='tmux split-window \; split-window -h \; select-pane -U \; split-window -h'
alias tmTri='tmux split-window  -h -p 33 \; split-window \; select-pane -L'
alias tmSwapA='tmux display-message -p "#{pane_id}" > ~/.swapPane'
alias tmAvailKeys='echo {a..z} {A..Z} | tr -d $(tmux lsk | sed "s/bind-key \(-r\)\{0,1\} *\([^ ]*\) .*/\2/" | sed -n "/^[a-zA-Z]$/p" | tr -d [:space:]) | tr -d \ '
alias d.='desk .'
alias snvm='source ~/.nvm/nvm.sh'
alias datestamp='date +%Y%m%d'
alias timestamp='date +%Y%m%d%H%M%S'
alias unixstamp='date +%s'

which nvim > /dev/null && alias vim='nvim'

#Aliases to use ag and git diff in color with less
alias gdl='git diff --color=always | less -R'
alias agless='ag --pager "less -r"'
alias :q=exit

#md5sum on linux is md5 on bsd/osx 
[[ -f /sbin/md5 ]] && alias md5sum='md5 -r'
# vim:ft=sh
