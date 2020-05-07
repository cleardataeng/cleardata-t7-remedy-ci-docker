FROM cleardata/bionic

ENV GOSWAGGER_VER 0.21.0
ENV NODE_VER 10.17.0
ENV TERRAFORM_VER 0.12.12

RUN apt-get -q update && \
	DEBIAN_FRONTEND=noninteractive apt-get -q install -y \
	autoconf \
	openjdk-8-jdk \
	groff

# Go-Swagger install
RUN wget https://github.com/go-swagger/go-swagger/releases/download/v$GOSWAGGER_VER/swagger_linux_amd64 -O /usr/local/bin/swagger && \
    chmod +x /usr/local/bin/swagger

# Install required node version
RUN curl https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash
RUN bash -c "source ~/.nvm/nvm.sh && nvm install $NODE_VER && nvm use --delete-prefix $NODE_VER && nvm alias default $NODE_VER"

RUN GO111MODULE=on go get github.com/mikefarah/yq/v3

# Remove existing TF and use tfenv
RUN rm $(which terraform)
RUN git clone https://github.com/tfutils/tfenv.git ${HOME}/.tfenv && \
    ln -s ${HOME}/.tfenv/bin/* /usr/local/bin
RUN tfenv install 0.11.14 && \
    tfenv install 0.12.6 && \ 
    tfenv install 0.12.10 && \ 
    tfenv install $TERRAFORM_VER
RUN tfenv use $TERRAFORM_VER
