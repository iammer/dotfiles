#
# Description: Common ember tasks
#

. ~/.nvm/nvm.sh
nvm use 6

# ember test
alias et="ember test"

# ember test --serve
alias ets="ember test --serve"

# Remove and clean everything (i.e. for use after ember-cli upgrade)
alias cleanAll="npm cache clear && bower cache clean && rm -rf node_modules bower_components tmp dist && npm install && bower install"

