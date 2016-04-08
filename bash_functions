up() {
	for ((i=1; i<=$1; i++)); do
		cd ..
	done
	pwd
}

tmSwapB() { 
	tmux bind-key $1 swap-pane -d -s `tmux display-message -p "#{pane_id}"` -t `cat ~/.swapPane`
}

datedir() {
	datedir=`datestamp`
	mkdir $datedir && cd $datedir
}

# vim:ft=sh
