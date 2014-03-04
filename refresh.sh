#!/bin/bash

git pull && git submodule init && git submodule update

[[ -d ~/.irssi ]] || ln -s ~/dotfiles/irssi ~/.irssi

#wget https://github.com/git/git/raw/master/contrib/completion/git-completion.bash -O bin/git-completion.bash

