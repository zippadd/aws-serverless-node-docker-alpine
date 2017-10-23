FROM node:6-stretch
LABEL maintainer="ZipPadd"

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
RUN npm install npm@latest -g

###Fix NPM Permissions###

###Install new packages###

#yarn
RUN apt-get install -y yarn

#zip
RUN apt-get install -y zip

#AWS cli
RUN apt-get install -y python-pip
RUN pip install awscli
RUN aws configure set default.region us-west-2

#AWS sam-local
RUN npm install -g process-nextick-args util-deprecate
RUN npm install -g aws-sam-local --unsafe-perm=true
