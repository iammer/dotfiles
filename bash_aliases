#Tmux aliases
which tmux-next 2> /dev/null > /dev/null && alias tmux=tmux-next
which tmux25 2> /dev/null > /dev/null && alias tmux=tmux25
alias tm='(tmux has 2>/dev/null && tmux attach) || tmux new'
alias tmMarkPane='echo $TMUX_PANE > ~/.markedPane'
alias tmJoinPane='tmux join-pane -s `cat ~/.markedPane`'
alias tmQuad='tmux split-window \; split-window -h \; select-pane -U \; split-window -h'
alias tmTri='tmux split-window  -h -p 33 \; split-window \; select-pane -L'
alias tmSwapA='tmux display-message -p "#{pane_id}" > ~/.swapPane'
alias tmAvailKeys='echo {a..z} {A..Z} | tr -d $(tmux lsk -T prefix | sed "s/bind-key \(-r\)\{0,1\} *-T \w* *\([^ ]*\) .*/\2/" | sed -n "/^[a-zA-Z]$/p" | tr -d [:space:]) | tr -d \ '
alias d.='desk .'
alias datestamp='date +%Y%m%d'
alias timestamp='date +%Y%m%d%H%M%S'
alias unixstamp='date +%s'

alias lessb='LESS=${LESS/S/} less'
alias agless='ag --pager "less -R"'

#Output header lines as well as body
alias curld='curl -D-'

alias gitwip="git commit -a -m '[ci skip] WIP' && git pull && git push"
alias gpo="git push -u origin \$(git rev-parse --abbrev-ref HEAD)"

alias randpass="head -c 12 < /dev/urandom | base64"

#Stop history logging. Use if you need to send a password as an arg
alias stophist='set +o history; O_PROMPT_COMMAND=$PROMPT_COMMAND; unset PROMPT_COMMAND'
alias starthist='set -o history; PROMPT_COMMAND=$O_PROMPT_COMMAND; unset O_PROMPT_COMMAND'

alias gcm='gcloud compute'
alias gcb='gcloud beta'
alias gcf='gcb functions'
alias dkr='docker'

alias rebash='exec bash -l'

which nvim 2> /dev/null > /dev/null && alias vim="`which nvim`"

#in case I forget I am not in vim
alias :q='exit'
alias jk='clear' 

#md5sum on linux is md5 on bsd/osx 
[[ -f /sbin/md5 ]] && alias md5sum='md5 -r'

#Headless chrome
alias headless-'chrome=google-chrome --headless --disable-gpu --remote-debugging-port=9222'

alias bashreload='exec -l bash'

# vim:ft=sh
