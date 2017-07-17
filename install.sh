#!/bin/bash
############################
# install.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

########## Variables

dir=~/dotfiles                    # dotfiles directory
olddir=~/dotfiles_old             # old dotfiles backup directory
files="bashrc vimrc vim tmux.conf irssi gitignore_global desk agignore ctags inputrc bash_profile jline.rc"    # list of files/folders to symlink in homedir
config_files="nvim"   #list of files/folders to symlink in .config
mac_files="tmux.osx.conf"

##########

[[ -x ~/.tmux.local.conf ]] && mv ~/.tmux.local.conf $olddir

case $OSTYPE in
	darwin* )
		echo "Detected OSX: copying tmux.osx.conf to tmux.local.conf"
		cp $dir/tmux.osx.conf ~/.tmux.local.conf
		;;
	* )
		echo "Creating empty tmux.local.conf"
		touch ~/.tmux.local.conf
		;;
esac

# create dotfiles_old in homedir
echo "Creating $olddir for backup of any existing dotfiles in ~"
mkdir -p $olddir/config
echo "...done"

# change to the dotfiles directory
echo "Changing to the $dir directory"
cd $dir
echo "...done"

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks 
for file in $files; do
    echo "Moving any existing dotfiles from ~ to $olddir"
    mv ~/.$file ~/dotfiles_old/
    echo "Creating symlink to $file in home directory."
    ln -s $dir/$file ~/.$file
done

[[ -d ~/.config ]] || mkdir ~/.config

for file in $config_files; do
	echo "Moving existing config from ~/.config/$file to $olddir/config/$file"
	mv ~/.config/$file ~/dotfiles_old/config/$file
	echo "Creating symlink to ~/.config/$file"
	ln -s $dir/$file ~/.config/$file
done

echo "Moving old .gitconfig"
mv ~/.gitconfig ~/dotfiles_old/

if [[ `git --version` == 'git version 1.7'* ]]; then
	echo 'Git 1.7 detected'
	echo "Creating symlink from gitconfig17 to .gitconfig"
	ln -s $dir/gitconfig17 ~/.gitconfig
else
	echo 'Git >1.7 detected'
	echo "Creating symlink from gitconfig18 to .gitconfig"
	ln -s $dir/gitconfig18 ~/.gitconfig
fi

[[ -d ~/bin ]] && mv ~/bin $olddir
[[ -d $dir/bin ]] && ln -s $dir/bin ~/bin

cd $dir
./refresh.sh
