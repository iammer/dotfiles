FROM iammer/dev-base

RUN sudo apt install -y autoconf automake build-essential python-dev &&\
	mkdir /build &&\
	cd /build &&\
	git clone https://github.com/facebook/watchman.git &&\
	cd watchman/ &&\
	git checkout v4.7.0 &&\
	./autogen.sh &&\
	./configure &&\
	make &&\
	make install &&\
	cd / &&\
	rm -R /build &&\
	apt remove -y autoconf automake python-dev &&\
	apt autoremove -y &&\
	su -c '\
		cd $HOME/dotfiles &&\
		./refresh.sh &&\
		curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.1/install.sh | bash &&\
		source ~/.nvm/nvm.sh &&\
		nvm install 7 &&\
		npm install -g ember-cli grunt supervisor bower \
	' michael
