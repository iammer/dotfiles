#!/bin/sh
set -x

if [ ! -f /etc/startup-script-did-run ]; then
	apt-get update
	apt-get install -y ssh git man less sudo mosh tmux curl build-essential silversearcher-ag entr jq parallel xz-utils openssl wget bzip2 w3m zip software-properties-common locales
	sed -i '/en_US.UTF-8/ s/# //' /etc/locale.gen
	locale-gen
	apt-add-repository -y ppa:neovim-ppa/stable
	apt update
	apt -y install neovim
	adduser --disabled-password --gecos "Michael Ratliff" michael
	su -c '
		cd $HOME && \
		git clone https://github.com/iammer/dotfiles.git && \
		pushd dotfiles && \
			./install.sh  && \
		popd && \
		rm -R dotfiles_old && \
		mkdir code \
	' michael
	touch /etc/startup-script-did-run
fi
