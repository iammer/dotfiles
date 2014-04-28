up() { pushd .; for ((i=1; i<=$1; i++)); do cd ..; done; pwd; }
