FROM quay.io/sporkmonger/secure-bootstrap
MAINTAINER Bob Aman <bob@sporkmonger.com>

RUN mkdir -p /opt/bin/

# Install compiler
RUN apk add --update gcc g++ libgcc make musl-dev libc-dev linux-headers \
  libffi-dev swig git

# Get access to edge & testing repositories
COPY repositories /etc/apk/repositories

# Install python & salt
RUN apk add --update openssl openssl-dev python python-dev py-openssl \
  zeromq && rm -rf /var/cache/apk/*

# Install pip
COPY get-pip.py /root/get-pip.py
RUN python /root/get-pip.py && rm /root/get-pip.py

# Install python dependencies
RUN pip install pyyaml jinja2 msgpack-python apache-libcloud requests \
  pyzmq pycrypto
RUN pip install https://github.com/M2Crypto/M2Crypto/zipball/master
RUN pip freeze --local
RUN pip install salt salt-api

CMD [ "/bin/bash" ]
