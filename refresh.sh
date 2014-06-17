#!/bin/bash

git pull && git submodule init && git submodule update

[[ -e ~/.gitignore_global ]] || ln -s ~/dotfiles/gitignore_global ~/.gitignore_global 

#wget https://github.com/git/git/raw/master/contrib/completion/git-completion.bash -O bin/git-completion.bash

