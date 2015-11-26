#!/bin/bash

git pull && git submodule init && git submodule update

#remove ctrlspace since it was removed from git
[[ -d vim/bundle/vim.ctrlspace ]] && rm -Rf vim/bundle/vim.ctrlspace

[[ -e ~/.gitignore_global ]] || ln -s ~/dotfiles/gitignore_global ~/.gitignore_global 

files="desk ctags agignore"
for file in $files; do
	[[ -L ~/.$file ]] || ln -s ~/dotfiles/$file ~/.$file  
done

[[ -e ~/dotfiles/bin/git-completion.bash ]] || wget https://github.com/git/git/raw/master/contrib/completion/git-completion.bash -O ~/dotfiles/bin/git-completion.bash

