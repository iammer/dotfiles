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
	mkdir -p $datedir; cd $datedir
}

comskip() {
	git commit -m "[ci skip] $1" && git pull && git push
}

addIfNotContains() {
	local VAR=$1
	local TO_ADD=$2
	eval "local VAL=\"\${$VAR}\""
	if [[ $VAL != *$TO_ADD* ]]; then
		eval "$VAR=\"$TO_ADD\${$VAR:+:\${$VAR}}\"; export $VAR"
	fi
}

ggs() {
	w3m "https://www.google.com/search?q=$*"
}

hclean() {
	rm -R .lesshst .config/gcloud/logs/* .local/share/nvim/undo/* .node_repl_history .python_history .sqlite_history .npm/_logs/* .wget_hsts .w3m/cookie .w3m/history .w3m/w3m* 2>/dev/null
}

urlencode() {
    # urlencode <string>
    old_lc_collate=$LC_COLLATE
    LC_COLLATE=C
    
    local length="${#1}"
    for (( i = 0; i < length; i++ )); do
        local c="${1:i:1}"
        case $c in
            [a-zA-Z0-9.~_-]) printf "$c" ;;
            *) printf '%%%02X' "'$c" ;;
        esac
    done
    
    LC_COLLATE=$old_lc_collate
}

urldecode() {
    # urldecode <string>

    local url_encoded="${1//+/ }"
    printf '%b' "${url_encoded//%/\\x}"
}

# vim:ft=sh
