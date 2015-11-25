# docker.sh
#
# Description: Commands to help work with docker instances
#

# alias for docker-machine
alias dm='docker-machine'

# setup environment for docker-maching
alias setupDMDev='eval "$(docker-machine env dev)"'
alias setupDMLM='eval "$(docker-machine env lowmem)"'


