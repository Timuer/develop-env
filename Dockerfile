FROM ubuntu:18.04

# backup apt sources list
RUN cp /etc/apt/sources.list /etc/apt/sources.list.bak
COPY apt-sources /etc/apt/sources.list

RUN apt-get update
	# download tools
	&& apt-get install -y git curl wget \
	# net tools
	&& apt-get install -y net-tools iputils-ping \
	# develop tools
	&& apt-get install -y build-essential cmake python3-dev python3 python3-pip 

# install vim8
RUN apt-get install -y software-properties-common \
	&& add-apt-repository ppa:jonathonf/vim \
	&& apt-get update \
	&& apt-get install -y vim

# node/npm support
RUN apt-get install -y node.js \
	&& apt-get install -y npm \
	&& npm config set registry http://registry.npm.taobao.org \
	&& npm install -g n \
	&& n stable

# configure vim
RUN git clone https://github.com/Timuer/vim-config.git \
	&& curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
RUN cp vim-config/.vimrc $HOME/.vimrc
COPY completer-config $HOME/.ycm_extra_conf.py
RUN apt-get -y install ctags

# set work directory
COPY . /var/mycode
WORKDIR /var/mycode

# flask environment
RUN pip3 install pipenv \
	&& pipenv install \
	&& pipenv run pip3 install flask
	
# RUN git clone https://github.com/vim/vim.git
# RUN apt-get -y install libncurses5-dev libgtk3.0-dev libatk1.0-dev libbonoboui2-dev libcairo2-dev libx11-dev libxpm-dev libxt-dev
# RUN cd vim
# RUN ./configure --with-features=huge --enable-multibyte \
#    --enable-python3interp --enable-cscope \
#	--with-python3-config-dir=/usr/lib/python3.6/config-3.6m-x86_64-linux-gnu/ \
#	--prefix=/usr/local/vim
# RUN make
# RUN make install



