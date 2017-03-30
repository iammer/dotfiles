#
# Description: Install things
#

# Homebrew package installer
alias brew='/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"'

# Necessary OSX things
alias brewBase='brew install ack bash coreutils entr findutils gawk git git-lfs gnu-sed gnu-tar gnutls grep jq mobile-shell neovim nmap openssl parallel perl readline tmux unzip vim w3m wget watchman xz zbackup the_silver_searcher'

# Necessary Linux things (use sudo)
debBase() {
	apt-get update
	apt-get -y install git tmux curl build-essentials vim silversearch-ag entr jq nmap parallel watchman xz zbackup openssl
}

# Install NVM
alias nvm='curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.1/install.sh | bash'

# Install Rust
alias rust='curl https://sh.rustup.rs -sSf | sh'

# Install SDKMan
alias sdkman='curl -s "https://get.sdkman.io" | bash'

