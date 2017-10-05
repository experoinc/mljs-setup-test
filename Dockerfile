FROM ubuntu:17.04

EXPOSE 8888
WORKDIR /home
RUN apt update
RUN apt install -y curl 
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" > /etc/apt/sources.list.d/yarn.list
RUN apt update
RUN apt install -y bzip2 nodejs yarn git
RUN yarn global add jp-babel

RUN curl https://repo.continuum.io/archive/Anaconda3-5.0.0.1-Linux-x86_64.sh > anaconda.sh && chmod +x anaconda.sh && ./anaconda.sh -b

RUN git clone https://github.com/experoinc/mljs-setup-test.git
WORKDIR mljs-setup-test
RUN yarn install
RUN mkdir /data
CMD PATH=/root/anaconda3/bin:$PATH jp-babel-notebook --allow-root --notebook-dir=/data --ip=*

