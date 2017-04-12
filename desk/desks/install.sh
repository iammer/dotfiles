#
# Description: Install things
#

# Homebrew package installer
alias brew='/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"'

# Necessary OSX things
alias brewBase='brew install ack bash coreutils entr findutils gawk git git-lfs gnu-sed gnu-tar gnutls grep jq mobile-shell neovim nmap openssl parallel perl readline tmux unzip vim w3m wget watchman xz zbackup the_silver_searcher'

# Necessary Linux things (uses sudo)
debBase() {
	sudo apt-get update
	sudo apt-get -y install git tmux curl build-essentials vim silversearch-ag entr jq nmap parallel watchman xz zbackup openssl
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
	rm /tmp/rus-init
}

# Install SDKMan
alias sdkman='curl -s "https://get.sdkman.io" | bash'

