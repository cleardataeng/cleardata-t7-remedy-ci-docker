FROM golang:1.12.4-alpine

RUN apk --no-cache --update add \
        bash \
        build-base \
        gcc \
        curl \
        git \
	openjdk8-jre \
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
    pip install --upgrade awscli==1.16.228 s3cmd==2.0.1 python-magic && \
    wget https://github.com/go-swagger/go-swagger/releases/download/v0.21.0/swagger_linux_amd64 -O /usr/local/bin/swagger && \
    chmod +x /usr/local/bin/swagger

RUN git clone https://github.com/tfutils/tfenv.git ${HOME}/.tfenv && \
    ln -s ${HOME}/.tfenv/bin/* /usr/local/bin

RUN tfenv install 0.11.14 && \
    tfenv install 0.12.6 && \ 
    tfenv install 0.12.10 && \ 
    tfenv install 0.12.12
    
RUN tfenv use 0.12.12
