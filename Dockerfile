FROM node:6-alpine
LABEL maintainer="ZipPadd"

###Clean up from source###

#yarn
RUN rm /usr/local/bin/yarn
RUN rm /usr/local/bin/yarnpkg

###Update packages###
RUN apk update
RUN apk upgrade
RUN npm install npm@latest -g
RUN apk add --update openssl

###Install new packages###

#yarn
RUN apk add yarn --update-cache --repository http://dl-3.alpinelinux.org/alpine/edge/community --allow-untrusted

#zip
RUN apk add zip

#AWS cli
RUN apk add py-pip
RUN pip install --upgrade pip
RUN pip install awscli
RUN aws configure set default.region us-west-2

#AWS sam-local
RUN wget -q https://github.com/awslabs/aws-sam-local/releases/download/v0.2.2/sam_0.2.2_linux_amd64.tar.gz
RUN gunzip sam_0.2.2_linux_amd64.tar.gz
RUN mkdir /opt/sam
RUN tar -xf sam_0.2.2_linux_amd64.tar -C /opt/sam
RUN rm sam_0.2.2_linux_amd64.tar
RUN apk add libc6-compat
RUN ln -s /lib /lib64
RUN ln -s /opt/sam/sam /usr/local/bin/sam
RUN chmod +x /usr/local/bin/sam
RUN sam --version
