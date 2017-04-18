FROM ubuntu:latest

RUN apt-get update && \
	apt-get install -y ssh git man less sudo\
		mosh tmux curl build-essential\
		silversearcher-ag entr jq parallel\
		xz-utils openssl wget bzip2 w3m\
		zip software-properties-common\
	&& \
	apt-add-repository -y ppa:neovim-ppa/stable && \
	apt update && \
	apt -y install neovim && \
	adduser --disabled-password --gecos "Michael Ratliff" michael && \
	adduser michael sudo && \
	mkdir /var/run/sshd && \
	chmod 0755 /var/run/sshd && \
	mkdir /home/michael/.ssh

ADD . /home/michael/dotfiles
COPY docker/sudoers /etc/sudoers
COPY authorized_keys /home/michael/.ssh/

RUN chown -R michael:michael /home/michael && \
	su -c '\
		cd $HOME && \
		chmod 600 .ssh/authorized_keys && \
		pushd dotfiles && \
			./install.sh  && \
			git remote set-url origin https://github.com/iammer/dotfiles.git && \
		popd && \
		rm -R dotfiles_old && \
		mkdir code \
	' michael

EXPOSE 22 8080 8443
ENTRYPOINT ["/usr/sbin/sshd","-D"]
VOLUME ["/home/michael/code"]



