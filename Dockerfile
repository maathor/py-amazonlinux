FROM amazonlinux:latest 

ARG PYTHON_VERSION=3.6.4
ARG BOTO3_VERSION=1.6.3
ARG BOTOCORE_VERSION=1.9.3
ARG APPUSER=app

RUN yum -y install wget \
                    aws-cli \
                    tar \
                    git \
                    zlib-dev \
                    pthreads \
                    make \
                    gcc \
                    autoconf \
                    gcc-c++ \
                    docker-ce \
                    docker-ce-cli \
                    containerd.io \
                    pkgconfig-0.27.1-4.amzn2.x86_64 \
                    zip
RUN amazon-linux-extras install docker

RUN yum -y update &&\
    yum install -y shadow-utils findutils gcc sqlite-devel zlib-devel \
                   bzip2-devel openssl-devel readline-devel libffi-devel && \
    groupadd ${APPUSER} && useradd ${APPUSER} -g ${APPUSER} && \
    cd /usr/local/src && \
    curl -O https://www.python.org/ftp/python/${PYTHON_VERSION}/Python-${PYTHON_VERSION}.tgz && \
    tar -xzf Python-${PYTHON_VERSION}.tgz && \
    cd Python-${PYTHON_VERSION} && \
    ./configure --enable-optimizations && make && make altinstall && \
    rm -rf /usr/local/src/Python-${PYTHON_VERSION}* && \
    yum remove -y shadow-utils audit-libs libcap-ng && yum -y autoremove && \
    yum clean all
    
WORKDIR /pyproject/
VOLUME /pyproject