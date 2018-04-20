FROM node:8-alpine

###Update packages###
RUN apk update && apk upgrade \
    && npm install npm@latest -g && apk add --update openssl \
###Install new packages###
#yarn (remove current one)
    && rm /usr/local/bin/yarn && rm /usr/local/bin/yarnpkg \
    && apk add yarn --update-cache --repository http://dl-3.alpinelinux.org/alpine/edge/community --allow-untrusted \
#zip
    && apk add zip \
#Parallel
    && apk add parallel \
#AWS cli
    && apk add py-pip && pip install --upgrade pip \
    && pip install awscli && aws configure set default.region us-west-2 \
#AWS sam-local
    && apk add libc6-compat && ln -s /lib /lib64 \
    && mkdir /opt/sam \
    && wget -q https://github.com/awslabs/aws-sam-local/releases/download/v0.2.11/sam_0.2.11_linux_amd64.tar.gz \
    && gunzip sam_0.2.11_linux_amd64.tar.gz \
    && tar -xf sam_0.2.11_linux_amd64.tar -C /opt/sam \
    && rm sam_0.2.11_linux_amd64.tar \
    && ln -s /opt/sam/sam /usr/local/bin/sam && chmod +x /usr/local/bin/sam
