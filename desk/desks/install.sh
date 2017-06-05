#
# Description: Install things
#

# Homebrew package installer
alias brew='/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"'

# Necessary OSX things
alias brewBase='brew install ack bash coreutils entr findutils gawk git git-lfs gnu-sed gnu-tar gnutls grep jq mobile-shell neovim nmap openssl parallel perl readline tmux unzip vim w3m wget watchman xz zbackup the_silver_searcher tree'

# Necessary Linux things (uses sudo)
debBase() {
	sudo apt-get update
	sudo apt-get -y install git tmux curl build-essential vim silversearcher-ag entr jq nmap parallel xz-utils zbackup openssl wget
}

#Neovim (uses sudo)
neovim() {
	sudo apt-get -y install software-properties-common
	sudo add-apt-repository ppa:neovim-ppa/stable
	sudo apt-get update
	sudo apt-get -y install neovim
}

# Install NVM
alias nvm='curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.1/install.sh | bash'

# Install Rust
rust() {
	curl https://sh.rustup.rs -sSf -o /tmp/rust-init &&
	chmod a+x /tmp/rust-init &&
	/tmp/rust-init -y --no-modify-path --default-toolchain nightly &&
	rm /tmp/rust-init
}

# Install SDKMan
sdkman () {
	curl -s "https://get.sdkman.io" | bash
	pushd $HOME/dotfiles
		git checkout -- bash_profile
	popd
	source $HOME/.sdkman/bin/sdkman-init.sh
}

# Setup for Min Dev
minDev() {
	nvm
	source $HOME/.nvm/nvm.sh
	nvm install 4.2
	sdkman
	sdk install java 7u80
	sdk install groovy 2.1.8
	sdk install grails 2.3.4
}

