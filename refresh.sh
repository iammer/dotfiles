#!/bin/bash

git pull && git submodule init && git submodule sync && git submodule update --init --recursive

#remove ctrlspace since it was removed from git
[[ -d vim/bundle/vim.ctrlspace ]] && rm -Rf vim/bundle/vim.ctrlspace

[[ -e ~/.gitignore_global ]] || ln -s ~/dotfiles/gitignore_global ~/.gitignore_global 

#files that where added after install script was first created and may not be
#present in newer versions
files="desk ctags agignore inputrc bash_profile jline.rc"
for file in $files; do
	if [[ ! -L ~/.$file ]]; then
		if [[ -f ~/.$file ]]; then
			[[ -d ~/dotfiles_old ]] || mkdir ~/dotfiles_old
			mv ~/.$file ~/dotfiles_old
		fi
		[[ -L ~/.$file ]] || ln -s ~/dotfiles/$file ~/.$file  
	fi
done

#files that where symlinked at one point, but it didn't actually make sense
files="bash_aliases bash_functions"
for file in $files; do
	if [[ -L ~/.$file ]]; then
		rm ~/.$file
	fi
done

config_files="nvim"
[[ -d ~/.config ]] || mkdir -p ~/.config
for file in $config_files; do
	[[ -L ~/.config/$file ]] || ln -s ~/dotfiles/$file ~/.config/$file
done

[[ -e ~/dotfiles/bin/git-completion.bash ]] || wget https://github.com/git/git/raw/master/contrib/completion/git-completion.bash -O ~/dotfiles/bin/git-completion.bash

