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

comskip() {
	git commit -m "[ci skip] $1" && git pull && git push
}

# vim:ft=sh
