FROM alpine:latest 

ARG PYTHON_VERSION=3.6.4
ARG BOTO3_VERSION=1.6.3
ARG BOTOCORE_VERSION=1.9.3

RUN apk add wget \
            alpine-sdk \
            tar \
            git \
            curl \
            zip \
            openssh \
            groff \ 
            less \
            openssl-dev \
            python3-dev \
            docker

RUN pip3 install awscli
  
WORKDIR /pyproject/
VOLUME /pyproject