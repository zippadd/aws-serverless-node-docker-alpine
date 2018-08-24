###Match AWS Lambda Node Version
FROM zippadd/node:8.10

###Update packages###
RUN echo "@edge http://dl-cdn.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories \
    && echo "@edgecommunity http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories \
    && apk update \
    && apk add --upgrade apk-tools@edge \
    && apk update \
    && apk upgrade \
    && npm install npm@latest -g \
###Install new packages###
#Parallel
    && apk add parallel \
#Temp add gcc and tools
    && apk add gcc python-dev libc6-compat linux-headers build-base \ 
#AWS cli
    && apk add python py-pip \
    && pip --no-cache-dir install --upgrade pip setuptools \
    && pip --no-cache-dir install awscli && aws configure set default.region us-west-2 && aws configure set default.s3.max_concurrent_requests 50 \
#AWS sam-local
    && pip --no-cache-dir install aws-sam-cli \
#Global NPM packages
    && yarn global add eslint eslint-config-standard eslint-plugin-import eslint-plugin-node eslint-plugin-promise eslint-plugin-standard eslint-plugin-react babel-eslint eslint-plugin-babel \
    && yarn global add lerna \
    && yarn global add jest \
###Clean Up
#Remove temp packages
    && apk del gcc python-dev libc6-compat linux-headers build-base \
#Clean caches
    && npm cache clean --force \
    && yarn cache clean \
    && rm /var/cache/apk/* \
###Verify
    && aws --version \
    && sam --version \
    && node --version \
    && npm --version \
    && yarn --version \
    && parallel --version
