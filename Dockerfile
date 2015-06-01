FROM quay.io/sporkmonger/secure-bootstrap
MAINTAINER Bob Aman <bob@sporkmonger.com>

RUN mkdir -p /opt/bin/

# Install compiler
RUN apk add --update gcc g++ libgcc make musl-dev libc-dev linux-headers \
  libffi-dev

# Get access to edge & testing repositories
COPY repositories /etc/apk/repositories

# Install python & salt
RUN apk add --update openssl openssl-dev python python-dev py-pip@edge zeromq \
  salt-api@testing && rm -rf /var/cache/apk/*

# Avoid warnings
RUN pip install pyopenssl

# Use the latest pip
RUN pip install --upgrade pip

# Install salt python dependencies
RUN pip install pyyaml jinja2 msgpack-python apache-libcloud requests \
  pyzmq

CMD [ "/bin/bash" ]
