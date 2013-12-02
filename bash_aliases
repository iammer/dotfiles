alias dg='grails -Djava.awt.headless=true -Ddeployment=spida/dev'
alias cg='grails -Djava.awt.headless=true -Ddeployment=spida/circleci'
alias ddg='grails-debug -Djava.awt.headless=true -Ddeployment=spida/dev'
alias dcg='grails-debug -Djava.awt.headless=true -Ddeployment=spida/circleci'

[[ -f /sbin/md5 ]] && alias md5sum='md5 -r'
