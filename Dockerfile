FROM ubuntu:18.04

# backup apt sources list
RUN cp /etc/apt/sources.list /etc/apt/sources.list.bak
COPY apt-sources /etc/apt/sources.list

RUN apt-get update
RUN apt-get -y install build-essential cmake python3-dev
RUN apt-get -y install python3 python3-pip
RUN apt-get -y install git curl

# set work directory
COPY . /var/mycode
WORKDIR /var/mycode

# install vim8
RUN apt-get install -y software-properties-common
RUN add-apt-repository ppa:jonathonf/vim
RUN apt-get update
RUN apt-get install -y vim

# RUN git clone https://github.com/vim/vim.git
# RUN apt-get -y install libncurses5-dev libgtk3.0-dev libatk1.0-dev libbonoboui2-dev libcairo2-dev libx11-dev libxpm-dev libxt-dev
# RUN cd vim
# RUN ./configure --with-features=huge --enable-multibyte \
#    --enable-python3interp --enable-cscope \
#	--with-python3-config-dir=/usr/lib/python3.6/config-3.6m-x86_64-linux-gnu/ \
#	--prefix=/usr/local/vim
# RUN make
# RUN make install

# node/npm support
# RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.34.0/install.sh | bash
# RUN nvm install node
# RUN npm install npm@latest -g

# configure vim
RUN git clone https://github.com/Timuer/vim-config.git
RUN cp vim-config/.vimrc $HOME/.vimrc
COPY completer-config $HOME/.ycm_extra_conf.py
RUN apt-get -y install ctags
RUN curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim




