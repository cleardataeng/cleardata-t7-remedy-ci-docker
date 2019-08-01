FROM golang:1.12.4-alpine

RUN apk --no-cache --update add \
        bash \
        build-base \
        gcc \
        git \
        openssh \
        openssh-client \
        openssl \
        jq \
        make \
        wget \
        zip \
        python \
        py-pip \
        groff \
        less \
        mailcap \
        nodejs \
        nodejs-npm \
        && \
    pip install --upgrade awscli==1.16.20 s3cmd==2.0.1 python-magic && \
    apk -v --purge del py-pip \
      && \
    wget https://releases.hashicorp.com/terraform/0.11.14/terraform_0.11.14_linux_amd64.zip -O tmp.zip && unzip tmp.zip -d /usr/local/bin/; rm tmp.zip \
      && \
    rm -rf .terraform \
      && \
    wget https://github.com/go-swagger/go-swagger/releases/download/v0.19.0/swagger_linux_amd64 -O /usr/local/bin/swagger \
      && \
    chmod +x /usr/local/bin/swagger
