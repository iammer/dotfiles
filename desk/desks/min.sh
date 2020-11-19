# grails.sh
# 
# Description: desk for min grails work
#

. ~/.nvm/nvm.sh
nvm use 6

cd ~/code/min

export JAVA_HOME=/opt/java7

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

DEFAULT_GRAILS_OPS="-Djava.awt.headless=true -Xmx4096M"

# Run grails with dev-servers deployment
alias dsg="./grailsw -reloading $DEFAULT_GRAILS_OPS -Ddeployment=spida/dev-servers"

# Run grails with dev-sqlserver deployment
alias dqg="./grailsw -reloading $DEFAULT_GRAILS_OPS -Ddeployment=spida/dev-sqlserver"

# Run grails with dev deployment
alias dg="./grailsw -reloading $DEFAULT_GRAILS_OPS -Djava.awt.headless=true -Ddeployment=dev"

alias dsg="./grailsw -reloading $DEFAULT_GRAILS_OPS -Ddeployment=spida/studio"

# Run grails with circleci deployment
alias cg="./grailsw $DEFAULT_GRAILS_OPS -Ddeployment=spida/circleci"

# Run grails in debug mode with dev deployment
alias ddg="./grailsw -debug-forked -reloading $DEFAULT_GRAILS_OPS -Ddeployment=spida/dev"

# Run grails in debug mode with circleci deployment
alias dcg="./grailsw -debug-forked -reloading $DEFAULT_GRAILS_OPS -Ddeployment=spida/circleci"

# Show the order in which grails tests were run
grailsTestOrder() {
    grep testsuite target/test-reports/TESTS-TestSuites.xml | grep -v testsuites | cut -d\  -f8-9 | sed -E 's/name="(.*)" package="(.*)"/\2.\1/' | grep .
}

# Repeat citests whenever a .groovy file changes
rtestci() {
	PARAMS="$@"
	find . -name '*.groovy' | entr -cs "(echo 'drop database circle_test; create database circle_test owner ubuntu;' | psql postgres) && redis-cli flushall && grails $DEFAULT_GRAILS_OPS -Ddeployment=spida/circleci test-app $PARAMS"
}




