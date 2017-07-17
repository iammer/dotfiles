# grails.sh
# 
# Description: desk for min grails work
#

. ~/.nvm/nvm.sh
nvm use 4

cd ~/code/min

#Cleans and compiles interchange and projectmanager (solves issues that occur when switch from ember non-ember min)
alias supaclean="pushd interchange && grails clean && grails compile && popd && pushd projectmanager && grails clean && grails compile && popd"

# Drop and recreate the cirle_test database
alias dropci="echo 'drop database circle_test; create database circle_test owner ubuntu;' | psql postgres"

# Drop and recreate the min database
alias dropmin="echo 'drop database minmasterdevelopment; create database minmasterdevelopment owner minmaster;' | psql postgres"
alias dropstudio="echo 'drop database minmasterstudio; create database minmasterstudio owner minmaster;' | psql postgres"

# Test min the same way it would be tested in CircleCI
alias testci="dropci && redis-cli flushall && cg test-app -plain-output"

# Test calcDB
alias testdb="./grailsw test-app -plain-output"

DEFAULT_GRAILS_OPS="-Djava.awt.headless=true"

# Run grails with dev-servers deployment
alias dsg="grails -reloading $DEFAULT_GRAILS_OPS -Ddeployment=spida/dev-servers"

# Run grails with dev-sqlserver deployment
alias dqg="grails -reloading $DEFAULT_GRAILS_OPS -Ddeployment=spida/dev-sqlserver"

# Run grails with dev deployment
alias dg="grails -reloading $DEFAULT_GRAILS_OPS -Djava.awt.headless=true -Ddeployment=spida/dev"

alias dsg="grails -reloading $DEFAULT_GRAILS_OPS -Ddeployment=spida/studio"

# Run grails with circleci deployment
alias cg="grails $DEFAULT_GRAILS_OPS -Ddeployment=spida/circleci"

# Run grails in debug mode with dev deployment
alias ddg="grails -debug-forked -reloading $DEFAULT_GRAILS_OPS -Ddeployment=spida/dev"

# Run grails in debug mode with circleci deployment
alias dcg="grails -debug-forked -reloading $DEFAULT_GRAILS_OPS -Ddeployment=spida/circleci"

# Show the order in which grails tests were run
grailsTestOrder() {
    grep testsuite target/test-reports/TESTS-TestSuites.xml | grep -v testsuites | cut -d\  -f8-9 | sed -E 's/name="(.*)" package="(.*)"/\2.\1/' | grep .
}

# Repeat citests whenever a .groovy file changes
rtestci() {
	PARAMS="$@"
	find . -name '*.groovy' | entr -cs "(echo 'drop database circle_test; create database circle_test owner ubuntu;' | psql postgres) && redis-cli flushall && grails $DEFAULT_GRAILS_OPS -Ddeployment=spida/circleci test-app $PARAMS"
}




