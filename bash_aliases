#Tmux aliases
alias tm='tmux attach || tmux new'
alias tmMarkPane='echo $TMUX_PANE > ~/.markedPane'
alias tmJoinPane='tmux join-pane -s `cat ~/.markedPane`'
alias tmQuad='tmux split-window \; split-window -h \; select-pane -U \; split-window -h'
alias tmTri='tmux split-window  -h -p 33 \; split-window \; select-pane -L'
alias tmSwapA='tmux display-message -p "#{pane_id}" > ~/.swapPane'
alias tmAvailKeys='echo {a..z} {A..Z} | tr -d $(tmux lsk | sed "s/bind-key \(-r\)\{0,1\} *\([^ ]*\) .*/\2/" | sed -n "/^[a-zA-Z]$/p" | tr -d [:space:]) | tr -d \ '
alias d.='desk .'
alias datestamp='date +%Y%m%d'
alias timestamp='date +%Y%m%d%H%M%S'
alias unixstamp='date +%s'

alias lessb='LESS=${LESS/S/} less'
alias agless='ag --pager "less -R"'

alias gitwip="git commit -a -m '[ci skip] WIP' && git pull && git push"
alias gpo="git push -u origin \$(git rev-parse --abbrev-ref HEAD)"

#Stop history logging. Use if you need to send a password as an arg
alias stophist='set +o history; O_PROMPT_COMMAND=$PROMPT_COMMAND; unset PROMPT_COMMAND'
alias starthist='set -o history; PROMPT_COMMAND=$O_PROMPT_COMMAND; unset O_PROMPT_COMMAND'

alias gcm='gcloud compute'
alias dkr='docker'

which nvim 2> /dev/null > /dev/null && alias vim="`which nvim`"

alias :q=exit

#md5sum on linux is md5 on bsd/osx 
[[ -f /sbin/md5 ]] && alias md5sum='md5 -r'

# vim:ft=sh
