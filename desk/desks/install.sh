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
	sudo apt-get -y install git tmux curl build-essential vim silversearcher-ag entr jq nmap parallel xz-utils zbackup openssl wget tree w3m
}

# Neovim (uses sudo)
neovim() {
	sudo apt-get -y install software-properties-common
	sudo add-apt-repository ppa:neovim-ppa/stable
	sudo apt-get update
	sudo apt-get -y install neovim
}

# Install NVM
alias nvm='curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.1/install.sh | bash'

# Install node (uses sudo)
node() {
	UNAME_MACH=$(uname -m)
	NODE_MACH='x64'
	case $UNAME_MACH in
		x86_64)
			NODE_MACH='x64'
			;;
		aarch64)
			NODE_MACH='arm64'
			;;
		i686)
			NODE_MACH='x86'
			;;
		*)
			NODE_MACH=$UNAME_MACH
			;;
	esac

	echo "Looking for machine type: $NODE_MACH"
	NODE_URL="https://nodejs.org/dist/latest"
	echo "Getting latest binaries"
	NODE_DIST=$(curl -s "$NODE_URL/SHASUMS256.txt" | awk "/linux-$NODE_MACH.tar.xz/ { print \$2 }")
	echo "Downloading $NODE_URL/$NODE_DIST"
	curl -o /tmp/node.tar.xz "$NODE_URL/$NODE_DIST"
	echo "Extracting"
	pushd /opt
		sudo tar xfv /tmp/node.tar.xz && rm /tmp/node.tar.xz
		sudo ln -sf /opt/${NODE_DIST%.tar.xz} /opt/node
	popd	
}

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

# Install chrome
chrome() {
	wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -O /tmp/chrome-stable.deb
	sudo dpkg -i /tmp/chrome-stable.deb
	sudo apt-get install -f -y
}

# Install docker
docker() {
	sudo apt install software-properties-common
	curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
	sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
	sudo apt-get update
	sudo apt-get install -y docker-ce
	sudo adduser $(whoami) docker
}
