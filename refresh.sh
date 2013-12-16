#!/bin/bash

git submodule init
git submodule update

wget https://github.com/git/git/raw/master/contrib/completion/git-completion.bash -O bin/git-completion.bash

