FROM node:6-stretch
MAINTAINER ZipPadd

###Enable HTTPs support###
RUN apt-get update
RUN apt-get install -y apt-transport-https

###Add sources###

#yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

###Update packages###
RUN apt-get update
RUN apt-get -y upgrade

###Install new packages###

#yarn
RUN apt-get install -y yarn

#zip
RUN apt-get install -y zip

#AWS cli
RUN apt-get install -y awscli
