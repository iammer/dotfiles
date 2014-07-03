up() { for ((i=1; i<=$1; i++)); do cd ..; done; pwd; }

tmSwapB() { 
	tmux bind-key $1 swap-pane -d -s `tmux display-message -p "#{pane_id}"` -t `cat ~/.swapPane`;
}

function grailsTestOrder() {
    grep testsuite target/test-reports/TESTS-TestSuites.xml | grep -v testsuites | cut -d\  -f8-9 | sed -E 's/name="(.*)" package="(.*)"/\2.\1/' | grep .
}
# vim:ft=sh
