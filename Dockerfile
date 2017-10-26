FROM ubuntu:latest

RUN apt-get update && \
	apt-get install -y ssh git man less sudo\
		mosh tmux curl build-essential\
		silversearcher-ag entr jq parallel\
		xz-utils openssl wget bzip2 w3m\
		zip software-properties-common\
		locales tree \
	&& \
	sed -i '/en_US.UTF-8/ s/# //' /etc/locale.gen && \
	locale-gen && \
	apt-add-repository -y ppa:neovim-ppa/stable && \
	apt update && \
	apt -y install neovim && \
	adduser --disabled-password --gecos "Michael Ratliff" michael && \
	adduser michael sudo && \
	mkdir /var/run/sshd && \
	chmod 0755 /var/run/sshd && \
	mkdir /home/michael/.ssh && \
	mkdir /code

ADD . /home/michael/dotfiles
COPY docker/sudoers /etc/sudoers
COPY authorized_keys /home/michael/.ssh/

RUN chown -R michael:michael /home/michael /code && \
	su -c '\
		cd $HOME && \
		chmod 600 .ssh/authorized_keys && \
		pushd dotfiles && \
			git remote set-url origin https://github.com/iammer/dotfiles.git && \
			./install.sh  && \
		popd && \
		rm -R dotfiles_old && \
		ln -s /code /home/michael \
	' michael

EXPOSE 22 8080 8443
ENTRYPOINT ["/usr/sbin/sshd","-D"]
VOLUME ["/code"]



