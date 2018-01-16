#!/bin/bash

#Load config for the thing that manages config (but where do I keep this?) :) 
[[ -f ~/.config/dotfiles/config ]] && source ~/.config/dotfiles/config

#Update submodules
git pull && git submodule init && git submodule sync && git submodule update --init --recursive

#cleanup removed submodules
removed_bundles="vim.ctrlspace"
for bundle in $removed_bundles; do
	[[ -d vim/bundle/$bundle ]] && rm -Rf vim/bundle/$bundle
done

[[ -e ~/.gitignore_global ]] || ln -s ~/dotfiles/gitignore_global ~/.gitignore_global 

#files that where added after install script was first created and may not be
#present in newer versions
files="desk ctags agignore inputrc bash_profile jline.rc"

#Allow not changing bash_profile (currently used for Termux)
[[ -n "$KEEP_PROFILE" ]] && files=${files/bash_profile}

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

#things to symlink in .config
config_files="nvim"
[[ -d ~/.config ]] || mkdir -p ~/.config
for file in $config_files; do
	[[ -L ~/.config/$file ]] || ln -s ~/dotfiles/$file ~/.config/$file
done

#things to symlink in .w3m
w3m_files="config keymap"
[[ -d ~/.w3m ]] || mkdir -p ~/.w3m
[[ -d ~/dotfiles_old/w3m ]] || mkdir -p ~/dotfiles_old/w3m
for file in $w3m_files; do
	if [[ ! -L ~/.w3m/$file ]]; then
		[[ -f ~/.w3m/$file ]] && mv ~/.w3m/$file ~/dotfiles_old/w3m
		ln -s ~/dotfiles/w3m/$file ~/.w3m/$file
	fi
done

[[ -e ~/dotfiles/bin/git-completion.bash ]] || wget https://github.com/git/git/raw/master/contrib/completion/git-completion.bash -O ~/dotfiles/bin/git-completion.bash

[[ -d ~/.local/share/nvim/undo ]] || mkdir -p ~/.local/share/nvim/undo
